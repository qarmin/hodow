// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawMultiExtTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The colour and stencil results are compared as raw bytes (upstream goes
// through `tcu::intThresholdCompare`/`dsThresholdCompare` with zero thresholds), and the multi draw commands are called
// through the loaded function pointers because the draw infos are packed with a caller-chosen stride, which a typed slice
// cannot express. The vertex buffer is bound at the allocation's offset, as upstream does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1};

use crate::generated::shaders::draw_multi_draw::MULTI_DRAW;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::GroupParams;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Normal or indexed draws.
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Normal,
    Indexed,
}

/// How to apply the vertex offset in indexed draws.
#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexOffsetType {
    /// Do not use pVertexOffset and mix values in struct-indicated offsets.
    Mixed,
    /// Use a constant value for pVertexOffset and fill offset struct members with random values.
    ConstantRandom,
    /// Use a constant value for pVertexOffset and a stride that removes the vertex offset member in structs.
    ConstantPack,
}

/// Triangle mesh type.
#[derive(Clone, Copy, PartialEq, Eq)]
enum MeshType {
    Mosaic,
    Overlapping,
}

/// Vertex offset parameters.
#[derive(Clone, Copy)]
struct VertexOffsetParams {
    offset_type: VertexOffsetType,
    offset: u32,
}

/// Test parameters.
#[derive(Clone, Copy)]
struct TestParams {
    mesh_type: MeshType,
    draw_type: DrawType,
    draw_count: u32,
    instance_count: u32,
    first_instance: u32,
    stride: u32,
    vertex_offset: Option<VertexOffsetParams>, // Only used for indexed draws.
    seed: u32,
    use_tessellation: bool,
    use_geometry: bool,
    multiview: bool,
    draw_id: bool,
    group_params: GroupParams,
}

impl TestParams {
    fn max_instance_index(&self) -> u32 {
        if self.instance_count == 0 {
            return 0;
        }
        self.first_instance + self.instance_count - 1
    }
}

/// For the color attachment. Must match what the fragment shader expects.
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;

/// Find a suitable format for the depth/stencil buffer.
fn choose_depth_stencil_format(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
) -> Result<vk::Format, TestError> {
    // The spec mandates support for one of these two formats.
    let candidates = [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT];

    for format in candidates {
        let properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
        if properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Ok(format);
        }
    }
    Err(TestError::Fail("No suitable depth/stencil format found".to_string()))
}

fn get_triangle_count() -> u32 {
    1024 // This matches the minumum allowed limit for maxMultiDrawCount, so we can submit a single triangle per draw call.
}

fn get_vertices_per_triangle() -> u32 {
    3
}

/// `TriangleMosaicGenerator::appendTriangle`: a triangle around the center of framebuffer pixel (x, y).
fn append_mosaic_triangle(width: u32, height: u32, x: u32, y: u32, vertices: &mut Vec<[f32; 4]>) {
    // Normalized width and height taking into account the framebuffer's width and height are two units (from -1 to 1).
    let pixel_width = 2.0 / width as f32;
    let pixel_height = 2.0 / height as f32;
    let delta_x = pixel_width * 0.25;
    let delta_y = pixel_height * 0.25;

    // Pixel center.
    let coord_x = (x as f32 + 0.5) * pixel_width - 1.0;
    let coord_y = (y as f32 + 0.5) * pixel_height - 1.0;

    // Triangle around it.
    let top_y = coord_y - delta_y;
    let bottom_y = coord_y + delta_y;

    let left_x = coord_x - delta_x;
    let right_x = coord_x + delta_x;

    // Note: clockwise.
    vertices.push([left_x, bottom_y, 0.0, 1.0]);
    vertices.push([coord_x, top_y, 0.0, 1.0]);
    vertices.push([right_x, bottom_y, 0.0, 1.0]);
}

/// `TriangleOverlapGenerator::appendTriangle`: full-screen triangle with 2D id (x, y) and decreasing depth with increasing ids.
/// This generator generates width*height full-screen triangles with decreasing depth from 0.75 to 0.25.
fn append_overlap_triangle(width: u32, height: u32, x: u32, y: u32, vertices: &mut Vec<[f32; 4]>) {
    const MIN_DEPTH: f32 = 0.25;
    const MAX_DEPTH: f32 = 0.75;
    const DEPTH_RANGE: f32 = MAX_DEPTH - MIN_DEPTH;

    let total_pixels = width * height;
    let depth_step = DEPTH_RANGE / total_pixels as f32;
    let pixel_id = (y * width + x) as f32;
    let depth = MAX_DEPTH - depth_step * pixel_id;

    // Note: clockwise.
    vertices.push([-1.0, -1.0, depth, 1.0]);
    vertices.push([4.0, -1.0, depth, 1.0]);
    vertices.push([-1.0, 4.0, depth, 1.0]);
}

/// `DrawInfoPacker` - helps creating a suitable draw info vector.
struct DrawInfoPacker {
    draw_type: DrawType,
    offset_type: Option<VertexOffsetType>, // Offset type when draw_type is DrawType::Indexed.
    stride: u32,       // Desired stride. Must be zero or at least as big as the needed VkMultiDraw*InfoExt.
    extra_bytes: u32,  // Used to match the desired stride.
    random: Random,    // Used to generate random offsets.
    info_count: u32,   // How many infos have we appended so far?
    data_vec: Vec<u8>, // Data vector in generic form.
    finalized: bool,   // Finished appending data.
}

const MULTI_DRAW_INFO_SIZE: u32 = std::mem::size_of::<vk::MultiDrawInfoEXT>() as u32;
const MULTI_DRAW_INDEXED_INFO_SIZE: u32 = std::mem::size_of::<vk::MultiDrawIndexedInfoEXT>() as u32;

impl DrawInfoPacker {
    /// Are draws indexed and using the offset member of VkMultiDrawIndexedInfoEXT?
    fn indexed_with_offset(draw_type: DrawType, offset_type: Option<VertexOffsetType>) -> bool {
        draw_type == DrawType::Indexed && offset_type != Some(VertexOffsetType::ConstantPack)
    }

    /// Are draws indexed and packed?
    fn indexed_packed(draw_type: DrawType, offset_type: Option<VertexOffsetType>) -> bool {
        draw_type == DrawType::Indexed && offset_type == Some(VertexOffsetType::ConstantPack)
    }

    /// Size in bytes for the base structure used with the given draw type.
    fn base_size(draw_type: DrawType, offset_type: Option<VertexOffsetType>) -> u32 {
        if Self::indexed_with_offset(draw_type, offset_type) {
            MULTI_DRAW_INDEXED_INFO_SIZE
        } else {
            MULTI_DRAW_INFO_SIZE
        }
    }

    /// Number of extra bytes per entry according to the given stride.
    fn calc_extra_bytes(draw_type: DrawType, offset_type: Option<VertexOffsetType>, stride: u32) -> u32 {
        // Stride 0 is a special allowed case.
        if stride == 0 {
            return 0;
        }

        let min_stride = Self::base_size(draw_type, offset_type);
        debug_assert!(stride >= min_stride);
        stride - min_stride
    }

    /// Entry size in bytes taking into account the number of extra bytes due to stride.
    fn entry_size(&self) -> u32 {
        Self::base_size(self.draw_type, self.offset_type) + self.extra_bytes
    }

    fn new(
        draw_type: DrawType,
        offset_type: Option<VertexOffsetType>,
        stride: u32,
        estimated_info_count: u32,
        seed: u32,
    ) -> Self {
        let mut packer = Self {
            draw_type,
            offset_type,
            stride,
            extra_bytes: Self::calc_extra_bytes(draw_type, offset_type, stride),
            random: Random::new(seed),
            info_count: 0,
            data_vec: Vec::new(),
            finalized: false,
        };
        // estimatedInfoCount is used to avoid excessive reallocation.
        packer
            .data_vec
            .reserve((estimated_info_count as usize + 1) * packer.entry_size() as usize);
        packer
    }

    fn add_draw_info(&mut self, first: u32, count: u32, offset: i32) {
        debug_assert!(!self.finalized);

        let mut entry = vec![0u8; self.entry_size() as usize];

        entry[0..4].copy_from_slice(&first.to_ne_bytes());
        entry[4..8].copy_from_slice(&count.to_ne_bytes());
        if Self::indexed_with_offset(self.draw_type, self.offset_type) {
            let used_offset = if self.offset_type == Some(VertexOffsetType::ConstantRandom) {
                self.random.get_uint32() as i32
            } else {
                offset
            };
            entry[8..12].copy_from_slice(&used_offset.to_ne_bytes());
        }

        self.data_vec.extend_from_slice(&entry);
        self.info_count += 1;
    }

    fn finalize(&mut self) {
        if Self::indexed_packed(self.draw_type, self.offset_type) && self.info_count > 0 {
            // VUID-vkCmdDrawMultiIndexedEXT-drawCount-04940 says:
            // If drawCount is greater than zero, pIndexInfo must be a valid pointer to memory containing one or more
            // valid instances of VkMultiDrawIndexedInfoEXT structures
            //
            // This means if infoCount is greater than zero, we need to have enough bytes in the buffer so that reading
            // a VkMultiDrawIndexedInfoEXT structure (12 bytes) at the last offset does not produce an OOB read. As
            // we've been packing data in the buffer using smaller VkMultiDrawInfoEXT structures, we need 4 extra bytes
            // at the end to make these tests legal.
            self.data_vec.extend_from_slice(&[0u8; std::mem::size_of::<i32>()]);
        }

        self.finalized = true;
    }

    fn draw_info_count(&self) -> u32 {
        debug_assert!(self.finalized);
        self.info_count
    }

    fn draw_info_data(&self) -> *const u8 {
        debug_assert!(self.finalized);
        self.data_vec.as_ptr()
    }

    fn stride(&self) -> u32 {
        self.stride
    }
}

struct MultiDrawTest {
    name: String,
    params: TestParams,
}

impl TestCase for MultiDrawTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultiDrawTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        context.require_device_functionality("VK_EXT_multi_draw")?;

        if params.draw_id {
            context.require_device_functionality("VK_KHR_shader_draw_parameters")?;
        }

        if params.use_tessellation && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: tessellationShader".to_string(),
            ));
        }

        if params.use_geometry && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }

        if params.multiview {
            let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };

            if multiview_features.multiview == vk::FALSE {
                return Err(TestError::NotSupported("Multiview not supported".to_string()));
            }

            if params.use_tessellation && multiview_features.multiview_tessellation_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Multiview not supported with tesellation shaders".to_string(),
                ));
            }

            if params.use_geometry && multiview_features.multiview_geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Multiview not supported with geometry shaders".to_string(),
                ));
            }
        }

        if params.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MULTI_DRAW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiDrawInstance {
            context,
            params: self.params,
        })
    }
}

struct MultiDrawInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn append_padding_vertices(vertices: &mut Vec<[f32; 4]>, count: u32) {
    for _ in 0..count {
        vertices.push([0.0, 0.0, 0.0, 1.0]);
    }
}

/// `makeMultidrawRenderPass` - creates a render pass with multiple subpasses, one per layer.
fn make_multidraw_render_pass(
    device: &Device,
    color_format: vk::Format,
    depth_stencil_format: vk::Format,
    layer_count: u32,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descriptions = [
        vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(depth_stencil_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let color_attachment_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let depth_stencil_attachment_ref = vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };

    let subpass_description = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_refs)
        .depth_stencil_attachment(&depth_stencil_attachment_ref)
        .build();
    let subpass_descriptions: Vec<vk::SubpassDescription> = (0..layer_count).map(|_| subpass_description).collect();

    let view_masks: Vec<u32> = (0..layer_count).map(|subpass_idx| 1u32 << subpass_idx).collect();
    let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder().view_masks(&view_masks);

    // Dependencies between subpasses for color and depth/stencil read/writes.
    let fragment_test_stages =
        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
    let ds_writes = vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
    let ds_read_writes =
        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ;
    let color_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
    let color_writes = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
    let color_read_writes = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ;

    let mut dependencies: Vec<vk::SubpassDependency> = Vec::new();
    for subpass_idx in 1..layer_count {
        let prev = subpass_idx - 1;

        dependencies.push(vk::SubpassDependency {
            src_subpass: prev,
            dst_subpass: subpass_idx,
            src_stage_mask: fragment_test_stages,
            dst_stage_mask: fragment_test_stages,
            src_access_mask: ds_writes,
            dst_access_mask: ds_read_writes,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        });

        dependencies.push(vk::SubpassDependency {
            src_subpass: prev,
            dst_subpass: subpass_idx,
            src_stage_mask: color_stage,
            dst_stage_mask: color_stage,
            src_access_mask: color_writes,
            dst_access_mask: color_read_writes,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        });
    }

    let mut render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpass_descriptions)
        .dependencies(&dependencies);
    if layer_count > 1 {
        render_pass_info = render_pass_info.push_next(&mut multiview_create_info);
    }

    let render_pass = unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// Everything `draw_commands` needs.
struct DrawBuffers {
    vertex_buffer: vk::Buffer,
    vertex_buffer_offset: vk::DeviceSize,
    vertex_offset: i32,
    index_buffer: vk::Buffer,
    index_buffer_offset: vk::DeviceSize,
    is_mixed_mode: bool,
}

impl MultiDrawInstance<'_> {
    /// `MultiDrawInstance::drawCommands`
    fn draw_commands(
        &self,
        cmd_buffer: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        buffers: &DrawBuffers,
        draw_infos: &DrawInfoPacker,
    ) {
        let device = self.context.get_device();

        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[buffers.vertex_buffer], &[buffers.vertex_buffer_offset]);

            if buffers.index_buffer == vk::Buffer::null() {
                (device.commands().cmd_draw_multi_ext)(
                    cmd_buffer,
                    draw_infos.draw_info_count(),
                    draw_infos.draw_info_data().cast::<vk::MultiDrawInfoEXT>(),
                    self.params.instance_count,
                    self.params.first_instance,
                    draw_infos.stride(),
                );
            } else {
                device.cmd_bind_index_buffer(
                    cmd_buffer,
                    buffers.index_buffer,
                    buffers.index_buffer_offset,
                    vk::IndexType::UINT32,
                );

                let offset_ptr: *const i32 = if buffers.is_mixed_mode {
                    std::ptr::null()
                } else {
                    &buffers.vertex_offset
                };
                (device.commands().cmd_draw_multi_indexed_ext)(
                    cmd_buffer,
                    draw_infos.draw_info_count(),
                    draw_infos.draw_info_data().cast::<vk::MultiDrawIndexedInfoEXT>(),
                    self.params.instance_count,
                    self.params.first_instance,
                    draw_infos.stride(),
                    offset_ptr,
                );
            }
        }
    }
}

impl TestInstance for MultiDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let q_index = context.get_universal_queue_family_index();
        let dynamic_rendering = params.group_params.use_dynamic_rendering;

        let color_format = COLOR_FORMAT;
        let ds_format = choose_depth_stencil_format(context.get_instance(), context.get_physical_device())?;
        let triangle_count = get_triangle_count();
        let image_dim = (triangle_count as f64).sqrt() as u32;
        let image_extent = vk::Extent3D {
            width: image_dim,
            height: image_dim,
            depth: 1,
        };
        let image_layers = if params.multiview { 2u32 } else { 1 };
        let image_view_type = if image_layers > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let pixel_count = image_extent.width * image_extent.height;
        let tri_vertex_count = get_vertices_per_triangle();
        let vertex_count = pixel_count * tri_vertex_count; // Triangle list.
        let is_indexed = params.draw_type == DrawType::Indexed;
        let is_mixed_mode = is_indexed
            && params
                .vertex_offset
                .is_some_and(|offset| offset.offset_type == VertexOffsetType::Mixed);
        let extra_vertices = params.vertex_offset.map_or(0, |offset| offset.offset);
        let extra_triangles = extra_vertices / tri_vertex_count;
        let is_mosaic = params.mesh_type == MeshType::Mosaic;
        let render_area = rect_2d(image_extent.width, image_extent.height);

        // Make sure we're providing a vertex offset for indexed cases.
        debug_assert!(!is_indexed || params.vertex_offset.is_some());

        // Make sure overlapping draws use a single instance.
        debug_assert!(is_mosaic || params.instance_count <= 1);

        // Color buffer.
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(image_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_info, MemoryRequirement::ANY)?;
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, image_layers);
        let color_buffer_view = make_image_view(
            device,
            color_buffer.get(),
            image_view_type,
            color_format,
            color_subresource_range,
        )?;

        // Depth/stencil buffer.
        let ds_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(ds_format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(image_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let ds_buffer = ImageWithMemory::new(device, alloc, ds_info, MemoryRequirement::ANY)?;
        let ds_subresource_range = make_image_subresource_range(
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            0,
            1,
            0,
            image_layers,
        );
        let ds_buffer_view = make_image_view(
            device,
            ds_buffer.get(),
            image_view_type,
            ds_format,
            ds_subresource_range,
        )?;

        // Buffers to read color attachment.
        let output_buffer_size = pixel_count as usize * 4;
        let mut output_buffers = Vec::new();
        for _ in 0..image_layers {
            output_buffers.push(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(output_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        // Buffer to read depth/stencil attachment. Note: this supposes we'll only copy the stencil aspect. See below.
        let stencil_out_buffer_size = pixel_count as usize;
        let mut stencil_out_buffers = Vec::new();
        for _ in 0..image_layers {
            stencil_out_buffers.push(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(
                    stencil_out_buffer_size as vk::DeviceSize,
                    vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        // Shaders.
        let binaries = context.get_binary_collection();
        let vert_name = format!(
            "vert_{}_{}",
            if params.multiview { "mv" } else { "sv" },
            if params.draw_id { "id" } else { "noid" }
        );
        let vert_module = create_shader_module(device, binaries.get(&vert_name)?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let geom_module = if params.use_geometry {
            Some(create_shader_module(device, binaries.get("geom")?)?)
        } else {
            None
        };
        let tess_modules = if params.use_tessellation {
            Some((
                create_shader_module(device, binaries.get("tesc")?)?,
                create_shader_module(device, binaries.get("tese")?)?,
            ))
        } else {
            None
        };

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Render pass and Framebuffer (note layers is always 1 as required by the spec).
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let render_pass = make_multidraw_render_pass(device, color_format, ds_format, image_layers)?;
            let framebuffer = make_framebuffer(
                device,
                *render_pass,
                &[*color_buffer_view, *ds_buffer_view],
                image_extent.width,
                image_extent.height,
                1,
            )?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Indexed draws will have triangle vertices in reverse order. See index buffer creation below.
        let front_face = if is_indexed {
            vk::FrontFace::COUNTER_CLOCKWISE
        } else {
            vk::FrontFace::CLOCKWISE
        };
        let front_stencil_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::INCREMENT_AND_WRAP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(0)
            .build();
        let back_stencil_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(0)
            .build();
        let depth_test_enable = if is_mosaic { vk::FALSE } else { vk::TRUE };
        let depth_write_enable = depth_test_enable;
        let depth_compare_op = if is_mosaic {
            vk::CompareOp::ALWAYS
        } else if is_indexed {
            vk::CompareOp::GREATER
        } else {
            vk::CompareOp::LESS
        };

        let primitive_topology = if params.use_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some((tesc_module, tese_module)) = &tess_modules {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc_module));
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese_module));
        }
        if let Some(geom_module) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom_module));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        // Pipelines.
        let mut pipelines = Vec::new();
        for subpass_idx in 0..image_layers {
            let mut state = DrawPipelineState::new(primitive_topology)
                .with_position_input()
                .with_full_viewport(image_extent.width, image_extent.height);
            state.rasterization.depth_clamp_enable = vk::FALSE;
            state.rasterization.cull_mode = vk::CullModeFlags::BACK;
            state.rasterization.front_face = front_face;
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.depth_stencil.depth_test_enable = depth_test_enable;
            state.depth_stencil.depth_write_enable = depth_write_enable;
            state.depth_stencil.depth_compare_op = depth_compare_op;
            state.depth_stencil.stencil_test_enable = vk::TRUE;
            state.depth_stencil.front = front_stencil_state;
            state.depth_stencil.back = back_stencil_state;
            if params.use_tessellation {
                state.patch_control_points = Some(tri_vertex_count);
            }
            if dynamic_rendering {
                state.rendering_format = Some(color_format);
                state.depth_rendering_format = ds_format;
                state.stencil_rendering_format = ds_format;
                state.view_mask = if params.multiview { 1 << subpass_idx } else { 0 };
            } else {
                state.subpass = subpass_idx;
            }
            pipelines.push(create_draw_pipeline(
                device,
                *pipeline_layout,
                render_pass_handle,
                &stages,
                &state,
            )?);
        }

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, q_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create vertex buffer.
        let mut triangle_vertices: Vec<[f32; 4]> = Vec::with_capacity((vertex_count + extra_vertices) as usize);

        // Vertex count per draw call.
        let at_least_one_draw = params.draw_count > 0;
        let more_than_one_draw = params.draw_count > 1;
        let triangles_per_draw = if at_least_one_draw {
            pixel_count / params.draw_count
        } else {
            0
        };
        let vertices_per_draw = triangles_per_draw * tri_vertex_count;

        if at_least_one_draw {
            debug_assert!(pixel_count.is_multiple_of(params.draw_count));
        }

        // When applying a vertex offset in nonmixed modes, there will be a few extra vertices at the start of the vertex buffer.
        if is_indexed && !is_mixed_mode {
            append_padding_vertices(&mut triangle_vertices, extra_vertices);
        }

        for y in 0..image_extent.height {
            for x in 0..image_extent.width {
                // When applying a vertex offset in mixed mode, there will be some extra padding between the triangles for the first
                // block and the rest, so that the vertex offset will not be constant in all draw info structures. This way, the first
                // triangles will always have offset zero, and the number of them depends on the given draw count.
                let pixel_index = y * image_extent.width + x;
                if is_indexed && is_mixed_mode && more_than_one_draw && pixel_index == triangles_per_draw {
                    append_padding_vertices(&mut triangle_vertices, extra_vertices);
                }

                if params.mesh_type == MeshType::Mosaic {
                    append_mosaic_triangle(image_extent.width, image_extent.height, x, y, &mut triangle_vertices);
                } else {
                    append_overlap_triangle(image_extent.width, image_extent.height, x, y, &mut triangle_vertices);
                }
            }
        }

        let vertex_buffer_size = std::mem::size_of_val(triangle_vertices.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                vertex_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_buffer_alloc = vertex_buffer.get_allocation();
        let vertex_buffer_offset = vertex_buffer_alloc.get_offset();
        unsafe {
            std::ptr::copy_nonoverlapping(
                triangle_vertices.as_ptr().cast::<u8>(),
                vertex_buffer_alloc.get_host_ptr(),
                vertex_buffer_size,
            )
        };
        flush_alloc(device, vertex_buffer_alloc)?;

        // Index buffer if needed.
        let mut index_buffer: Option<BufferWithMemory> = None;
        let mut index_buffer_offset: vk::DeviceSize = 0;
        let mut index_buffer_handle = vk::Buffer::null();

        if is_indexed {
            // Indices will be given in reverse order, so they effectively also make the triangles have reverse winding order.
            let indices: Vec<u32> = (0..vertex_count).map(|i| vertex_count - i - 1).collect();

            let index_buffer_size = std::mem::size_of_val(indices.as_slice());
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(index_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::INDEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let index_buffer_alloc = buffer.get_allocation();
            index_buffer_offset = index_buffer_alloc.get_offset();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indices.as_ptr().cast::<u8>(),
                    index_buffer_alloc.get_host_ptr(),
                    index_buffer_size,
                )
            };
            flush_alloc(device, index_buffer_alloc)?;
            index_buffer_handle = buffer.get();
            index_buffer = Some(buffer);
        }

        // Prepare draw information.
        let offset_type = params.vertex_offset.map(|offset| offset.offset_type);
        let vertex_offset = extra_vertices as i32;

        let mut draw_infos = DrawInfoPacker::new(
            params.draw_type,
            offset_type,
            params.stride,
            params.draw_count,
            params.seed,
        );

        if at_least_one_draw {
            let mut vertex_index = 0u32;
            for draw_idx in 0..params.draw_count {
                // For indexed draws in mixed offset mode, taking into account vertex indices have been stored in reverse
                // order and there may be a padding in the vertex buffer after the first verticesPerDraw vertices, we need
                // to use offset 0 in the last draw call. That draw will contain the indices for the first verticesPerDraw
                // vertices, which are stored without any offset, while other draw calls will use indices which are off by
                // extraVertices vertices. This will make sure not every draw call will use the same offset and the
                // implementation handles that.
                let draw_offset =
                    if is_indexed && (!is_mixed_mode || (more_than_one_draw && draw_idx < params.draw_count - 1)) {
                        vertex_offset
                    } else {
                        0
                    };
                draw_infos.add_draw_info(vertex_index, vertices_per_draw, draw_offset);
                vertex_index += vertices_per_draw;
            }
        }
        draw_infos.finalize();

        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue { uint32: [0, 0, 0, 0] },
        };
        let clear_depth_stencil = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: if is_mosaic || is_indexed { 0.0 } else { 1.0 },
                stencil: 0,
            },
        };
        let clear_values = [clear_color, clear_depth_stencil];

        let buffers = DrawBuffers {
            vertex_buffer: vertex_buffer.get(),
            vertex_buffer_offset,
            vertex_offset,
            index_buffer: index_buffer_handle,
            index_buffer_offset,
            is_mixed_mode,
        };

        // `beginRendering` with a depth and a stencil attachment on the same view
        let begin_rendering = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags, view_mask: u32| {
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_buffer_view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_color)
                .build()];
            let ds_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*ds_buffer_view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_depth_stencil)
                .build();
            let rendering_info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(render_area)
                .layer_count(image_layers)
                .view_mask(view_mask)
                .color_attachments(&color_attachments)
                .depth_attachment(&ds_attachment)
                .stencil_attachment(&ds_attachment);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        };

        // `beginSecondaryCmdBuffer`
        let begin_secondary_cmd_buffer =
            |cmd: vk::CommandBuffer, rendering_flags: vk::RenderingFlags, view_mask: u32| -> Result<(), TestError> {
                let color_formats = [color_format];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(rendering_flags)
                    .view_mask(view_mask)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(ds_format)
                    .stencil_attachment_format(ds_format)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !params
                    .group_params
                    .secondary_cmd_buffer_completely_contains_dynamic_renderpass
                {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
            };

        // `preRenderingCommands` - transition color and depth stencil attachment to the proper initial layout for dynamic rendering
        let pre_rendering_commands = |cmd: vk::CommandBuffer| {
            let color_pre_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.get(),
                color_subresource_range,
            );
            let ds_pre_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_buffer.get(),
                ds_subresource_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_pre_barrier],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[ds_pre_barrier],
                );
            }
        };

        let mut sec_cmd_buffers = Vec::new();
        if params.group_params.use_secondary_cmd_buffer {
            let contains = params
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            for layer_idx in 0..image_layers {
                let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
                let sec = *sec_cmd_buffer;
                let view_mask = if params.multiview { 1u32 << layer_idx } else { 0 };

                // record secondary command buffer
                if contains {
                    begin_secondary_cmd_buffer(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS, view_mask)?;
                    begin_rendering(sec, vk::RenderingFlags::empty(), view_mask);
                } else {
                    begin_secondary_cmd_buffer(sec, vk::RenderingFlags::empty(), view_mask)?;
                }

                self.draw_commands(sec, *pipelines[layer_idx as usize], &buffers, &draw_infos);

                if contains {
                    end_rendering(device, sec);
                }

                end_command_buffer(device, sec)?;
                sec_cmd_buffers.push(sec_cmd_buffer);
            }

            // record primary command buffer
            begin_command_buffer(device, *cmd_buffer)?;
            pre_rendering_commands(*cmd_buffer);

            for layer_idx in 0..image_layers {
                if !contains {
                    begin_rendering(
                        *cmd_buffer,
                        vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS,
                        if params.multiview { 1 << layer_idx } else { 0 },
                    );
                }

                unsafe { device.cmd_execute_commands(*cmd_buffer, &[*sec_cmd_buffers[layer_idx as usize]]) };

                if !contains {
                    end_rendering(device, *cmd_buffer);
                }
            }
        } else {
            begin_command_buffer(device, *cmd_buffer)?;

            if dynamic_rendering {
                pre_rendering_commands(*cmd_buffer);
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass_handle)
                    .framebuffer(framebuffer_handle)
                    .render_area(render_area)
                    .clear_values(&clear_values);
                unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            }

            for layer_idx in 0..image_layers {
                if dynamic_rendering {
                    begin_rendering(
                        *cmd_buffer,
                        vk::RenderingFlags::empty(),
                        if params.multiview { 1 << layer_idx } else { 0 },
                    );
                } else if layer_idx > 0 {
                    unsafe { device.cmd_next_subpass(*cmd_buffer, vk::SubpassContents::INLINE) };
                }

                self.draw_commands(*cmd_buffer, *pipelines[layer_idx as usize], &buffers, &draw_infos);

                if dynamic_rendering {
                    end_rendering(device, *cmd_buffer);
                }
            }

            if !dynamic_rendering {
                unsafe { device.cmd_end_render_pass(*cmd_buffer) };
            }
        }

        // Prepare images for copying.
        let color_buffer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_buffer.get(),
            color_subresource_range,
        );
        let ds_buffer_barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            ds_buffer.get(),
            ds_subresource_range,
        );
        let output_buffer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_buffer_barrier],
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[ds_buffer_barrier],
            );

            // Copy images to output buffers.
            for layer_idx in 0..image_layers {
                let color_copy_region = make_buffer_image_copy(
                    image_extent,
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer_idx, 1),
                );
                device.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    color_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    output_buffers[layer_idx as usize].get(),
                    &[color_copy_region],
                );
            }

            // Note: this only copies the stencil aspect. See stencilOutBuffer creation.
            for layer_idx in 0..image_layers {
                let stencil_copy_region = make_buffer_image_copy(
                    image_extent,
                    make_image_subresource_layers(vk::ImageAspectFlags::STENCIL, 0, layer_idx, 1),
                );
                device.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    ds_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    stencil_out_buffers[layer_idx as usize].get(),
                    &[stencil_copy_region],
                );
            }

            // Prepare buffers for host reading.
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[output_buffer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Read output buffers and verify their contents.

        // With stride zero, mosaic meshes increment the stencil buffer as many times as draw operations for affected pixels and
        // overlapping meshes increment the stencil buffer only in the first draw operation (the rest fail the depth test) as many times
        // as triangles per draw.
        //
        // With nonzero stride, mosaic meshes increment the stencil buffer once per pixel. Overlapping meshes increment it once per
        // triangle.
        let stencil_increments = if params.stride == 0 {
            if is_mosaic {
                draw_infos.draw_info_count()
            } else {
                triangles_per_draw
            }
        } else if is_mosaic {
            1
        } else {
            triangle_count
        };
        let max_instance_index = params.max_instance_index();
        let i_width = image_extent.width as i32;
        let i_height = image_extent.height as i32;

        // Keep the index buffer alive until the work using it is done.
        drop(index_buffer);

        for layer_idx in 0..image_layers {
            let output_buffer_alloc = output_buffers[layer_idx as usize].get_allocation();
            invalidate_alloc(device, output_buffer_alloc)?;
            let color_bytes =
                unsafe { std::slice::from_raw_parts(output_buffer_alloc.get_host_ptr(), output_buffer_size) };

            let stencil_out_buffer_alloc = stencil_out_buffers[layer_idx as usize].get_allocation();
            invalidate_alloc(device, stencil_out_buffer_alloc)?;
            let stencil_bytes =
                unsafe { std::slice::from_raw_parts(stencil_out_buffer_alloc.get_host_ptr(), stencil_out_buffer_size) };

            // Generate reference images.
            let mut ref_color = vec![0u8; output_buffer_size];
            let mut ref_stencil = vec![0u8; stencil_out_buffer_size];

            for y in 0..i_height {
                for x in 0..i_width {
                    let pixel_number = (y * i_width + x) as u32;
                    let triangle_index = if is_indexed {
                        pixel_count - 1 - pixel_number
                    } else {
                        pixel_number
                    }; // Reverse order for indexed draws.
                    let pixel = pixel_number as usize;

                    let (reference_color, reference_stencil): ([u8; 4], u8) = if params.instance_count == 0
                        || draw_infos.draw_info_count() == 0
                        || (params.stride == 0 && triangle_index >= triangles_per_draw && is_mosaic)
                    {
                        // Some pixels may not be drawn into when there are no instances or draws, or when the stride is zero in mosaic mode.
                        ([0, 0, 0, 0], 0)
                    } else {
                        // This must match the vertex shader.

                        let stored_val: u32 = if params.draw_id {
                            // With stride zero, the same block is drawn over and over again in each draw call. This affects both the draw index and
                            // the values in the depth/stencil buffer and, with overlapping meshes, only the first draw passes the depth test.
                            //
                            // With nonzero stride, the draw index depends on the triangle index and the number of triangles per draw and, for
                            // overlapping meshes, the draw index is always the last one.
                            if params.stride == 0 {
                                if is_mosaic { draw_infos.draw_info_count() - 1 } else { 0 }
                            } else if is_mosaic {
                                triangle_index / triangles_per_draw
                            } else {
                                draw_infos.draw_info_count() - 1
                            }
                        } else if is_mosaic {
                            let triangle_id = if is_indexed {
                                triangle_count - triangle_index - 1
                            } else {
                                triangle_index
                            };
                            let prim_offset = if is_indexed
                                && (!is_mixed_mode || (more_than_one_draw && triangle_id >= triangles_per_draw))
                            {
                                extra_triangles
                            } else {
                                0
                            };
                            triangle_id + prim_offset
                        } else if params.stride == 0 && more_than_one_draw {
                            if is_indexed {
                                pixel_count - triangles_per_draw + extra_triangles
                            } else {
                                triangles_per_draw - 1
                            }
                        } else {
                            if is_indexed {
                                if is_mixed_mode { 0 } else { extra_triangles }
                            } else {
                                pixel_count - 1
                            }
                        };

                        (
                            [
                                ((stored_val >> 8) & 0xFF) as u8,
                                (stored_val & 0xFF) as u8,
                                (255 - max_instance_index) as u8,
                                (255 - layer_idx) as u8,
                            ],
                            ((params.instance_count * stencil_increments) % 256) as u8, // VK_STENCIL_OP_INCREMENT_AND_WRAP.
                        )
                    };

                    ref_color[pixel * 4..pixel * 4 + 4].copy_from_slice(&reference_color);
                    ref_stencil[pixel] = reference_stencil;
                }
            }

            if color_bytes != ref_color.as_slice() {
                return Ok(TestStatus::fail(
                    "Color image comparison failed; check log for more details",
                ));
            }

            if stencil_bytes != ref_stencil.as_slice() {
                return Ok(TestStatus::fail(
                    "Stencil image comparison failed; check log for more details",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDrawMultiExtTests`
pub fn create_draw_multi_ext_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut draw_multi_group = TestCaseGroup::new("multi_draw");

    let mesh_type_cases = [(MeshType::Mosaic, "mosaic"), (MeshType::Overlapping, "overlapping")];
    let draw_type_cases = [(DrawType::Normal, "normal"), (DrawType::Indexed, "indexed")];
    let offset_type_cases: [(Option<VertexOffsetType>, &str); 4] = [
        (None, ""),
        (Some(VertexOffsetType::Mixed), "mixed"),
        (Some(VertexOffsetType::ConstantRandom), "random"),
        (Some(VertexOffsetType::ConstantPack), "packed"),
    ];
    let draw_count_cases = [
        (0u32, "no_draws"),
        (1, "one_draw"),
        (16, "16_draws"),
        (get_triangle_count(), "max_draws"),
    ];
    // extraBytes -1 means stride zero
    let stride_cases = [
        (-1i32, "stride_zero"),
        (0, "standard_stride"),
        (4, "stride_extra_4"),
        (12, "stride_extra_12"),
    ];
    // (firstInstance, instanceCount, name)
    let instance_cases = [
        (0u32, 0u32, "no_instances"),
        (0, 1, "1_instance"),
        (0, 10, "10_instances"),
        (3, 2, "2_instances_base_3"),
    ];
    let shader_cases = [
        (false, false, "vert_only"),
        (false, true, "with_geom"),
        (true, false, "with_tess"),
        (true, true, "tess_geom"),
    ];
    let draw_id_cases = [(true, ""), (false, "_no_draw_id")];
    let multiview_cases = [(false, "single_view"), (true, "multiview")];

    const SEED: u32 = 1621260419;

    for (mesh_type, mesh_type_name) in mesh_type_cases {
        // reduce number of tests for dynamic rendering cases where secondary command buffer is used
        if group_params.use_secondary_cmd_buffer && mesh_type != MeshType::Mosaic {
            continue;
        }

        let mut mesh_type_group = TestCaseGroup::new(mesh_type_name);

        for (draw_type, draw_type_name) in draw_type_cases {
            for (vertex_offset_type, offset_type_name) in offset_type_cases {
                // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                if group_params.use_secondary_cmd_buffer
                    && vertex_offset_type.is_some_and(|offset_type| offset_type != VertexOffsetType::ConstantRandom)
                {
                    continue;
                }

                let has_offset_type = vertex_offset_type.is_some();
                if (draw_type == DrawType::Normal && has_offset_type)
                    || (draw_type == DrawType::Indexed && !has_offset_type)
                {
                    continue;
                }

                let mut draw_group_name = draw_type_name.to_string();
                if has_offset_type {
                    draw_group_name.push('_');
                    draw_group_name.push_str(offset_type_name);
                }

                let mut draw_type_group = TestCaseGroup::new(&draw_group_name);

                for (draw_count, draw_count_name) in draw_count_cases {
                    // reduce number of tests for dynamic rendering cases where secondary command buffer is used
                    if group_params.use_secondary_cmd_buffer && draw_count != 1 {
                        continue;
                    }

                    let mut draw_count_group = TestCaseGroup::new(draw_count_name);

                    for (extra_bytes, stride_name) in stride_cases {
                        let mut stride_group = TestCaseGroup::new(stride_name);

                        for (first_instance, instance_count, instance_name) in instance_cases {
                            let mut instance_group = TestCaseGroup::new(instance_name);

                            for (use_tessellation, use_geometry, shader_name) in shader_cases {
                                let mut shader_group = TestCaseGroup::new(shader_name);

                                for (multiview, multiview_name) in multiview_cases {
                                    let mut multiview_group = TestCaseGroup::new(multiview_name);

                                    for (draw_id, suffix) in draw_id_cases {
                                        let is_indexed = draw_type == DrawType::Indexed;
                                        let is_packed = vertex_offset_type == Some(VertexOffsetType::ConstantPack);
                                        let base_stride = if is_indexed && !is_packed {
                                            MULTI_DRAW_INDEXED_INFO_SIZE
                                        } else {
                                            MULTI_DRAW_INFO_SIZE
                                        };
                                        let test_offset = if is_indexed {
                                            vertex_offset_type
                                                .map(|offset_type| VertexOffsetParams { offset_type, offset: 0 })
                                        } else {
                                            None
                                        };
                                        let mut test_stride = 0u32;

                                        if extra_bytes >= 0 {
                                            test_stride = base_stride + extra_bytes as u32;
                                        }

                                        if draw_count > 1 {
                                            // VUID-vkCmdDrawMultiEXT-drawCount-09628
                                            // VUID-vkCmdDrawMultiIndexedEXT-drawCount-09629
                                            let min_stride = if is_indexed {
                                                MULTI_DRAW_INDEXED_INFO_SIZE
                                            } else {
                                                MULTI_DRAW_INFO_SIZE
                                            };
                                            if test_stride < min_stride || !test_stride.is_multiple_of(4) {
                                                continue;
                                            }
                                        }

                                        // For overlapping triangles we will skip instanced drawing.
                                        if instance_count > 1 && mesh_type == MeshType::Overlapping {
                                            continue;
                                        }

                                        let mut params = TestParams {
                                            mesh_type,
                                            draw_type,
                                            draw_count,
                                            instance_count,
                                            first_instance,
                                            stride: test_stride,
                                            vertex_offset: test_offset,
                                            seed: SEED,
                                            use_tessellation,
                                            use_geometry,
                                            multiview,
                                            draw_id,
                                            group_params,
                                        };

                                        multiview_group.add_child(Box::new(MultiDrawTest {
                                            name: format!("no_offset{suffix}"),
                                            params,
                                        })
                                            as Box<dyn TestCase>);

                                        if is_indexed {
                                            if let Some(vertex_offset) = params.vertex_offset.as_mut() {
                                                vertex_offset.offset = 6;
                                            }
                                            multiview_group.add_child(Box::new(MultiDrawTest {
                                                name: format!("offset_6{suffix}"),
                                                params,
                                            })
                                                as Box<dyn TestCase>);
                                        }
                                    }

                                    shader_group.add_child(multiview_group);
                                }

                                instance_group.add_child(shader_group);
                            }

                            stride_group.add_child(instance_group);
                        }

                        draw_count_group.add_child(stride_group);
                    }

                    draw_type_group.add_child(draw_count_group);
                }

                mesh_type_group.add_child(draw_type_group);
            }
        }

        draw_multi_group.add_child(mesh_type_group);
    }
    draw_multi_group
}
