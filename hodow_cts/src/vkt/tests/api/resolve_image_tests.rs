// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiResolveTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The multisampled source is produced by a draw, not an upload: clear to blue, then
// one triangle covering the upper-right half in green. FILL_MODE_MULTISAMPLE builds
// the same split on the host, so the reference is analytical - what the comparison has
// to tolerate is only the resolved edge, which is what tcu::fuzzyCompare is for.
//
// Ported so far: the options that need no intermediate copy. The
// `*_copy_before_resolving` groups verify the copy with a subpass-input shader whose
// attachment count follows the layer count, and are not registered.

use vulkanalia::prelude::v1_0::*;

use super::copies_buffer_tests::AllocationKind;
use super::copies_image_tests::{FillMode, ImageParms, generate_buffer, read_image, upload_image};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass_with_samples,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vkt::{Context, TestCase, TestInstance};

/// `resolveExtent`
const RESOLVE_EXTENT: [u32; 3] = [256, 256, 1];
/// `samples[]`
const SAMPLES: [vk::SampleCountFlags; 6] = [
    vk::SampleCountFlags::_2,
    vk::SampleCountFlags::_4,
    vk::SampleCountFlags::_8,
    vk::SampleCountFlags::_16,
    vk::SampleCountFlags::_32,
    vk::SampleCountFlags::_64,
];
/// `fuzzyThreshold`
const FUZZY_THRESHOLD: f32 = 0.01;

/// `CopyRegion::imageResolve`, narrowed to the single-layer options that are ported.
#[derive(Clone, Copy)]
pub struct ImageResolve {
    pub src_offset: [i32; 3],
    pub dst_offset: [i32; 3],
    pub extent: [u32; 3],
}

impl ImageResolve {
    fn to_vk(self) -> vk::ImageResolve {
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        vk::ImageResolve {
            src_subresource: layers,
            src_offset: vk::Offset3D {
                x: self.src_offset[0],
                y: self.src_offset[1],
                z: self.src_offset[2],
            },
            dst_subresource: layers,
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

/// `ResolveImageToImageTestCase`
pub struct ResolveImageCase {
    name: String,
    src: ImageParms,
    dst: ImageParms,
    regions: Vec<ImageResolve>,
    samples: vk::SampleCountFlags,
    /// `TestParams::imageOffset` - bind the multisampled image at one alignment into
    /// its allocation rather than at zero.
    image_offset: bool,
    allocation_kind: AllocationKind,
}

impl TestCase for ResolveImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !context.get_device_properties().limits.framebuffer_color_sample_counts.contains(self.samples) {
            return Err(TestError::NotSupported("Unsupported number of rasterization samples".to_string()));
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        let instance = context.get_instance();
        for (parms, usage) in [
            (
                &self.src,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            ),
            (&self.dst, vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST),
        ] {
            unsafe {
                instance.get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    parms.format,
                    parms.image_type,
                    parms.tiling,
                    usage,
                    vk::ImageCreateFlags::empty(),
                )
            }
            .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::api_resolve_image::RESOLVE_IMAGE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ResolveImageInstance { context, params: self })
    }
}

struct ResolveImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ResolveImageCase,
}

impl TestInstance for ResolveImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let families = [queue_family_index];

        let src_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let dst_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let [w, h, _] = p.src.extent;

        // The multisampled colour attachment the draw fills.
        let ms_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: p.src.create_flags(),
            image_type: p.src.image_type,
            format: p.src.format,
            extent: p.src.extent_3d(),
            mip_levels: 1,
            array_layers: p.src.array_size(),
            samples: p.samples,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let multisampled = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(device, allocator, ms_info, MemoryRequirement::ANY)?
        } else if p.image_offset {
            ImageWithMemory::new_at_alignment_offset(device, allocator, ms_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(device, allocator, ms_info, MemoryRequirement::ANY)?
        };

        // The single-sampled destination, pre-filled so an unwritten region is visible.
        let dst_info = vk::ImageCreateInfo {
            samples: vk::SampleCountFlags::_1,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            image_type: p.dst.image_type,
            format: p.dst.format,
            extent: p.dst.extent_3d(),
            array_layers: p.dst.array_size(),
            flags: p.dst.create_flags(),
            ..ms_info
        };
        let destination = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(device, allocator, dst_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(device, allocator, dst_info, MemoryRequirement::ANY)?
        };

        let mut destination_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(
            &mut destination_level.get_access(),
            p.dst.extent[0],
            p.dst.extent[1],
            p.dst.extent[2],
            FillMode::Gradient,
            false,
        );
        upload_image(self.context, &destination_level.get_const_access(), destination.get(), &p.dst, false, &families, false)?;

        // `generateExpectedResult` - the destination with each region overwritten by
        // the pattern the draw is designed to produce.
        let mut source_level = TextureLevel::new(src_format, p.src.extent[0], p.src.extent[1], p.dst.extent[2])?;
        generate_buffer(
            &mut source_level.get_access(),
            p.src.extent[0],
            p.src.extent[1],
            p.dst.extent[2],
            FillMode::Multisample,
            false,
        );
        let mut expected_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let src_access = source_level.get_const_access();
            let mut expected = expected_level.get_access();
            for r in &p.regions {
                expected.copy_region_from(
                    &src_access,
                    (r.src_offset[0] as u32, r.src_offset[1] as u32, r.src_offset[2] as u32),
                    (r.dst_offset[0] as u32, r.dst_offset[1] as u32, r.dst_offset[2] as u32),
                    (r.extent[0], r.extent[1], r.extent[2]),
                );
            }
        }

        // Render the pattern into the multisampled image.
        let programs = p.programs();
        let render_pass = make_render_pass_with_samples(device, p.src.format, p.samples)?;
        let attachment_view = make_image_view(
            device,
            multisampled.get(),
            vk::ImageViewType::_2D,
            p.src.format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*attachment_view], w, h, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let frag = create_shader_module(device, programs.get("frag")?)?;
        let pipeline = make_graphics_pipeline_ms(device, *pipeline_layout, *vert, *frag, *render_pass, (w, h), p.samples)?;

        // `createQuad` - the upper-right half of the target.
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];
        let vertex_data_size = std::mem::size_of_val(&vertices) as u64;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_data_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(vertices.as_ptr().cast::<u8>(), vertex_buffer.get_allocation().get_host_ptr(), vertex_data_size as usize) };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let ms_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.array_size());
        let dst_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.dst.array_size());

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            let to_attachment = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                multisampled.get(),
                ms_range,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_attachment],
            );

            let clear = vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0, 0.0, 1.0, 1.0] },
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D { width: w, height: h },
                })
                .clear_values(std::slice::from_ref(&clear));
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);

            let to_src = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                multisampled.get(),
                ms_range,
            );
            let dst_to_dst = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                destination.get(),
                dst_range,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src, dst_to_dst],
            );

            let resolves: Vec<vk::ImageResolve> = p.regions.iter().map(|r| r.to_vk()).collect();
            device.cmd_resolve_image(
                *cmd_buffer,
                multisampled.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                destination.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &resolves,
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, false, &families)?;

        // `checkTestResult` - fuzzy, because the resolved diagonal is the one place the
        // driver and the analytical reference are allowed to disagree.
        let ok = fuzzy_compare_ok(&expected_level.get_const_access(), &result_level.get_const_access(), FUZZY_THRESHOLD)
            .ok_or_else(|| TestError::NotPorted(format!("fuzzy comparison of {dst_format:?}")))?;
        if ok {
            Ok(TestStatus::pass("CopiesAndBlitting test"))
        } else {
            Ok(TestStatus::fail("CopiesAndBlitting test"))
        }
    }
}

/// `makeGraphicsPipeline` with a multisampled rasterisation state.
fn make_graphics_pipeline_ms<'a>(
    device: &'a vulkanalia::Device,
    pipeline_layout: vk::PipelineLayout,
    vert: vk::ShaderModule,
    frag: vk::ShaderModule,
    render_pass: vk::RenderPass,
    render_size: (u32, u32),
    samples: vk::SampleCountFlags,
) -> Result<crate::vk::ref_util::Unique<'a, vk::Pipeline>, TestError> {
    crate::vk::obj_util::make_graphics_pipeline_with_samples(device, pipeline_layout, vert, frag, render_pass, render_size, vk::PrimitiveTopology::TRIANGLE_LIST, samples)
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

fn resolve_parms(format: vk::Format, extent: [u32; 3]) -> ImageParms {
    ImageParms {
        image_type: vk::ImageType::_2D,
        format,
        extent,
        tiling: vk::ImageTiling::OPTIMAL,
        fill_mode: FillMode::Gradient,
        create_flags: None,
    }
}

/// The three registrations that need no intermediate copy: they differ only in their
/// region list, and in whether the `_bind_offset` variant exists.
fn add_resolve_group(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind, regions: &[ImageResolve], with_bind_offset: bool) {
    for samples in SAMPLES {
        let make = |name: String, image_offset: bool| ResolveImageCase {
            name,
            src: resolve_parms(vk::Format::R8G8B8A8_UNORM, RESOLVE_EXTENT),
            dst: resolve_parms(vk::Format::R8G8B8A8_UNORM, RESOLVE_EXTENT),
            regions: regions.to_vec(),
            samples,
            image_offset,
            allocation_kind,
        };
        let base = sample_count_case_name(samples);
        group.add_child(Box::new(make(base.to_string(), false)) as Box<dyn TestCase>);
        if with_bind_offset && allocation_kind != AllocationKind::Dedicated {
            group.add_child(Box::new(make(format!("{base}_bind_offset"), true)) as Box<dyn TestCase>);
        }
    }
}

/// `addResolveImageTests`, minus the groups that need the intermediate-copy shader.
pub fn add_resolve_image_tests(parent: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind) {
    let mut group = tcu::TestCaseGroup::new("resolve_image");

    // `addResolveImageWholeTests`
    let mut whole = tcu::TestCaseGroup::new("whole");
    add_resolve_group(
        &mut whole,
        allocation_kind,
        &[ImageResolve {
            src_offset: [0, 0, 0],
            dst_offset: [0, 0, 0],
            extent: RESOLVE_EXTENT,
        }],
        true,
    );
    group.add_child(whole);

    // `addResolveImagePartialTests`
    let mut partial = tcu::TestCaseGroup::new("partial");
    add_resolve_group(
        &mut partial,
        allocation_kind,
        &[ImageResolve {
            src_offset: [0, 0, 0],
            dst_offset: [64, 64, 0],
            extent: [128, 128, 1],
        }],
        true,
    );
    group.add_child(partial);

    // `addResolveImageWithRegionsTests`
    let mut with_regions = tcu::TestCaseGroup::new("with_regions");
    let regions: Vec<ImageResolve> = (0..256)
        .step_by(64)
        .map(|i| ImageResolve {
            src_offset: [i, i, 0],
            dst_offset: [i, 0, 0],
            extent: [64, 64, 1],
        })
        .collect();
    add_resolve_group(&mut with_regions, allocation_kind, &regions, false);
    group.add_child(with_regions);

    // `addResolveImageDiffImageSizeTests` - the region stays the full resolveExtent
    // while one side's image is made larger in one axis.
    let mut diff_size = tcu::TestCaseGroup::new("diff_image_size");
    let whole = [ImageResolve {
        src_offset: [0, 0, 0],
        dst_offset: [0, 0, 0],
        extent: RESOLVE_EXTENT,
    }];
    let image_extents = [
        [RESOLVE_EXTENT[0] + 10, RESOLVE_EXTENT[1], RESOLVE_EXTENT[2]],
        [RESOLVE_EXTENT[0], RESOLVE_EXTENT[1] * 2, RESOLVE_EXTENT[2]],
        [RESOLVE_EXTENT[0], RESOLVE_EXTENT[1], RESOLVE_EXTENT[2] + 10],
    ];
    // Only the destination half gets the bind-offset variant upstream.
    for (prefix, vary_src, with_bind_offset) in [("src", true, false), ("dst", false, true)] {
        for extent in image_extents {
            let (src_extent, dst_extent) = if vary_src { (extent, RESOLVE_EXTENT) } else { (RESOLVE_EXTENT, extent) };
            for samples in SAMPLES {
                let make = |name: String, image_offset: bool| ResolveImageCase {
                    name,
                    src: resolve_parms(vk::Format::R8G8B8A8_UNORM, src_extent),
                    dst: resolve_parms(vk::Format::R8G8B8A8_UNORM, dst_extent),
                    regions: whole.to_vec(),
                    samples,
                    image_offset,
                    allocation_kind,
                };
                let base = format!("{prefix}_{}_{}_{}_{}", extent[0], extent[1], extent[2], sample_count_case_name(samples));
                diff_size.add_child(Box::new(make(base.clone(), false)) as Box<dyn TestCase>);
                if with_bind_offset && allocation_kind != AllocationKind::Dedicated {
                    diff_size.add_child(Box::new(make(format!("{base}_bind_offset"), true)) as Box<dyn TestCase>);
                }
            }
        }
    }
    group.add_child(diff_size);

    parent.add_child(group);
}
