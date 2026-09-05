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
// The `*_copy_before_resolving` options insert a multisample-to-multisample copy
// before the resolve and resolve the copy instead. A resolve alone cannot tell whether
// that copy moved every sample or just smeared one across the lot, so those options
// also run a second render pass that reads the source and the copy as multisampled
// subpass inputs and writes a per-sample verdict to an SSBO.
//
// Not ported: the `_no_cab`, `_compute` and `_transfer` variants, which need a second
// copy image without COLOR_ATTACHMENT usage and a compute-only / transfer-only queue.

use vulkanalia::prelude::v1_0::*;

use super::copies_buffer_tests::AllocationKind;
use super::copies_image_tests::{FillMode, ImageParms, generate_buffer, read_image_in_layout, upload_image};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout};
use crate::vk::programs::{BinaryCollection, create_shader_module};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `defaultExtent`
const DEFAULT_EXTENT: [u32; 3] = [64, 64, 1];
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
/// `VK_REMAINING_ARRAY_LAYERS`
const REMAINING_ARRAY_LAYERS: u32 = u32::MAX;

/// `ResolveImageToImageOptions`, minus the three variants that are not ported.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ResolveOptions {
    NoOptionalOperation,
    CopyMsImageToMsImage,
    CopyMsImageToArrayMsImage,
    CopyMsImageLayerToMsImage,
    CopyMsImageToMsImageMultiregion,
}

impl ResolveOptions {
    /// `ResolveImageToImage::shouldVerifyIntermediateResults`
    fn should_verify_intermediate_results(self) -> bool {
        matches!(self, Self::CopyMsImageToMsImage | Self::CopyMsImageToArrayMsImage | Self::CopyMsImageLayerToMsImage)
    }

    fn copies_before_resolving(self) -> bool {
        self != Self::NoOptionalOperation
    }
}

/// `CopyRegion::imageResolve`. Every registration builds one `sourceLayer` and uses it
/// for both subresources, so one layer range covers both sides.
#[derive(Clone, Copy)]
pub struct ImageResolve {
    pub base_array_layer: u32,
    pub layer_count: u32,
    pub src_offset: [i32; 3],
    pub dst_offset: [i32; 3],
    pub extent: [u32; 3],
}

impl ImageResolve {
    /// A whole-image, single-layer region - what most registrations use.
    fn whole(extent: [u32; 3]) -> Self {
        Self {
            base_array_layer: 0,
            layer_count: 1,
            src_offset: [0, 0, 0],
            dst_offset: [0, 0, 0],
            extent,
        }
    }

    fn layers(&self) -> vk::ImageSubresourceLayers {
        vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: self.base_array_layer,
            layer_count: self.layer_count,
        }
    }

    /// How many layers this region touches, once `VK_REMAINING_ARRAY_LAYERS` is
    /// resolved against the source it is read from.
    fn resolved_layer_count(&self, src_depth: u32) -> u32 {
        if self.layer_count == REMAINING_ARRAY_LAYERS {
            src_depth - self.base_array_layer
        } else {
            self.layer_count
        }
    }

    fn to_vk(self, src_offset: [i32; 3], extent: [u32; 3]) -> vk::ImageResolve {
        vk::ImageResolve {
            src_subresource: self.layers(),
            src_offset: vk::Offset3D {
                x: src_offset[0],
                y: src_offset[1],
                z: src_offset[2],
            },
            dst_subresource: self.layers(),
            dst_offset: vk::Offset3D {
                x: self.dst_offset[0],
                y: self.dst_offset[1],
                z: self.dst_offset[2],
            },
            extent: vk::Extent3D {
                width: extent[0],
                height: extent[1],
                depth: extent[2],
            },
        }
    }
}

/// `ResolveImageToImageTestCase`
pub struct ResolveImageCase {
    name: String,
    src: ImageParms,
    dst: ImageParms,
    src_layout: vk::ImageLayout,
    dst_layout: vk::ImageLayout,
    regions: Vec<ImageResolve>,
    samples: vk::SampleCountFlags,
    options: ResolveOptions,
    /// `TestParams::imageOffset` - bind the multisampled image at one alignment into
    /// its allocation rather than at zero.
    image_offset: bool,
    /// `MAINTENANCE_5` in `TestParams::extensionFlags`, which is what makes
    /// `VK_REMAINING_ARRAY_LAYERS` legal in a resolve subresource.
    needs_maintenance5: bool,
    allocation_kind: AllocationKind,
}

impl TestCase for ResolveImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // The intermediate result check writes an SSBO from the fragment shader.
        if self.options.should_verify_intermediate_results() && context.get_device_features().fragment_stores_and_atomics == 0 {
            return Err(TestError::NotSupported("fragmentStoresAndAtomics not supported".to_string()));
        }

        if !context.get_device_properties().limits.framebuffer_color_sample_counts.contains(self.samples) {
            return Err(TestError::NotSupported("Unsupported number of rasterization samples".to_string()));
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        let instance = context.get_instance();
        for (parms, usage) in [(&self.src, vk::ImageUsageFlags::TRANSFER_SRC), (&self.dst, vk::ImageUsageFlags::TRANSFER_DST)] {
            unsafe {
                instance.get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    parms.format,
                    parms.image_type,
                    vk::ImageTiling::OPTIMAL,
                    usage,
                    vk::ImageCreateFlags::empty(),
                )
            }
            .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;
        }

        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
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

impl ResolveImageCase {
    /// The verification shader: one subpass input per destination layer plus the
    /// source, so the layer count picks the variant.
    fn verify_programs(&self) -> BinaryCollection {
        use crate::generated::shaders::api_resolve_image::{RESOLVE_VERIFY_ARRAY, RESOLVE_VERIFY_SINGLE};
        if self.num_input_attachments() == 2 {
            RESOLVE_VERIFY_SINGLE.programs
        } else {
            RESOLVE_VERIFY_ARRAY.programs
        }
    }

    /// `numInputAttachments` - one per destination layer, plus the source image.
    fn num_input_attachments(&self) -> u32 {
        if self.options == ResolveOptions::CopyMsImageLayerToMsImage {
            2
        } else {
            self.dst.array_size() + 1
        }
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

        // `m_multisampledCopyImage` - the intermediate the copy options resolve from.
        // Its layer count follows the destination, so a one-layer source can be
        // fanned out across an array.
        let multisampled_copy = if p.options.copies_before_resolving() {
            let info = vk::ImageCreateInfo {
                array_layers: match p.options {
                    ResolveOptions::CopyMsImageLayerToMsImage | ResolveOptions::CopyMsImageToArrayMsImage => p.dst.array_size(),
                    _ => p.src.array_size(),
                },
                ..ms_info
            };
            Some(ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?)
        } else {
            None
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

        self.render_multisampled_source(&multisampled, multisampled_copy.as_ref())?;

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
            let src_depth = src_access.size()[2];
            let mut expected = expected_level.get_access();
            for r in &p.regions {
                // `copyRegionToTextureLevel` - the layer index is the z offset.
                let depth = r.resolved_layer_count(src_depth);
                expected.copy_region_from(
                    &src_access,
                    (r.src_offset[0] as u32, r.src_offset[1] as u32, r.base_array_layer),
                    (r.dst_offset[0] as u32, r.dst_offset[1] as u32, r.base_array_layer),
                    (r.extent[0], r.extent[1], depth),
                );
            }
        }

        // The copy options resolve the copy, not the image the draw wrote.
        let mut source_image = multisampled.get();
        let mut source_array_size = p.src.array_size();
        if p.options.copies_before_resolving() {
            if matches!(p.options, ResolveOptions::CopyMsImageLayerToMsImage | ResolveOptions::CopyMsImageToArrayMsImage) {
                source_array_size = p.dst.array_size();
            }
            let copy_image = multisampled_copy.as_ref().expect("copy image exists for every copy option");
            self.copy_ms_image_to_ms_image(&multisampled, copy_image, source_array_size)?;
            source_image = copy_image.get();
        }

        // `MULTIREGION` resolves the same regions the copy wrote, which means reading
        // the copy at the offset the copy put them at, not the source's offset.
        let partial_extent = [p.src.extent[0] / 2, p.src.extent[1] / 2, p.src.extent_3d().depth];
        let resolves: Vec<vk::ImageResolve> = p
            .regions
            .iter()
            .map(|r| {
                if p.options == ResolveOptions::CopyMsImageToMsImageMultiregion {
                    r.to_vk(r.dst_offset, partial_extent)
                } else {
                    r.to_vk(r.src_offset, r.extent)
                }
            })
            .collect();

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let src_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, source_array_size);
        let dst_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.dst.array_size());

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            let image_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    if p.options == ResolveOptions::NoOptionalOperation { p.dst_layout } else { p.src_layout },
                    p.src_layout,
                    source_image,
                    src_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    p.dst_layout,
                    destination.get(),
                    dst_range,
                ),
            ];
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );

            device.cmd_resolve_image(*cmd_buffer, source_image, p.src_layout, destination.get(), p.dst_layout, &resolves);

            let post = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                p.dst_layout,
                p.dst_layout,
                destination.get(),
                dst_range,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image_in_layout(self.context, destination.get(), &p.dst, &mut result_level, p.dst_layout, &families)?;

        if p.options.should_verify_intermediate_results() {
            // A resolve on its own cannot distinguish a copy that moved every sample
            // from one that broadcast a single sample over all of them.
            let copy_image = multisampled_copy.as_ref().expect("copy image exists for every verified option");
            let intermediate = self.check_intermediate_copy(&multisampled, copy_image)?;
            if intermediate.code() != tcu::TestResult::Pass {
                return Ok(intermediate);
            }
        }

        Ok(self.check_test_result(&expected_level, &result_level))
    }
}

impl ResolveImageInstance<'_> {
    /// The draw the whole test is built on: clear to blue, then one triangle over the
    /// upper-right half in green. Upstream does this in the instance constructor.
    fn render_multisampled_source(&self, multisampled: &ImageWithMemory<'_>, multisampled_copy: Option<&ImageWithMemory<'_>>) -> Result<(), TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let [w, h, _] = p.src.extent;

        // The layer-to-layer copy draws into layer 2 and leaves the rest as cleared.
        let base_array_layer = if p.options == ResolveOptions::CopyMsImageLayerToMsImage { 2 } else { 0 };
        // Whether the two images are cleared before the draw, and so whether the render
        // pass needs an external dependency against that clear.
        let pre_clear = matches!(p.options, ResolveOptions::CopyMsImageLayerToMsImage | ResolveOptions::CopyMsImageToMsImageMultiregion);

        let render_pass = make_resolve_render_pass(device, p.src.format, p.samples, pre_clear)?;
        let attachment_view = make_image_view(
            device,
            multisampled.get(),
            vk::ImageViewType::_2D,
            p.src.format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer, 1),
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*attachment_view], w, h, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let programs = p.programs();
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let frag = create_shader_module(device, programs.get("frag")?)?;
        let pipeline = crate::vk::obj_util::make_graphics_pipeline_with_samples(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *render_pass,
            (w, h),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            p.samples,
        )?;

        // `createQuad` - the upper-right half of the target.
        let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];
        let vertex_buffer = upload_vertices(device, allocator, &vertices)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // `srcImageBarriers` - both images start undefined and end up ready to be
        // either cleared or rendered into.
        let mut src_image_barriers = vec![make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::MEMORY_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            multisampled.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.array_size()),
        )];
        if let Some(copy) = multisampled_copy {
            src_image_barriers.push(make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::MEMORY_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                copy.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.dst.array_size()),
            ));
        }

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                if pre_clear {
                    vk::PipelineStageFlags::TRANSFER
                } else {
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                },
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &src_image_barriers,
            );

            if pre_clear {
                // Black in the source and white in the copy, so a layer the copy never
                // wrote is distinguishable from one it did.
                let clear_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.extent[2]);
                let black = vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 1.0] };
                device.cmd_clear_color_image(*cmd_buffer, multisampled.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &black, &[clear_range]);
                let white = vk::ClearColorValue { float32: [1.0, 1.0, 1.0, 1.0] };
                let copy = multisampled_copy.expect("a cleared copy image exists for both pre-clear options");
                device.cmd_clear_color_image(*cmd_buffer, copy.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &white, &[clear_range]);
            }

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
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;
        Ok(())
    }

    /// `ResolveImageToImage::copyMSImageToMSImage`
    fn copy_ms_image_to_ms_image(&self, multisampled: &ImageWithMemory<'_>, copy_image: &ImageWithMemory<'_>, copy_array_size: u32) -> Result<(), TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let extent = p.src.extent_3d();

        let layers = |base_array_layer: u32, layer_count: u32| vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer,
            layer_count,
        };
        let zero = vk::Offset3D { x: 0, y: 0, z: 0 };

        let image_copies: Vec<vk::ImageCopy> = match p.options {
            ResolveOptions::CopyMsImageLayerToMsImage => vec![vk::ImageCopy {
                src_subresource: layers(2, 1),
                src_offset: zero,
                dst_subresource: layers(4, 1),
                dst_offset: zero,
                extent,
            }],
            ResolveOptions::CopyMsImageToMsImageMultiregion => {
                let partial_extent = vk::Extent3D {
                    width: extent.width / 2,
                    height: extent.height / 2,
                    depth: extent.depth,
                };
                p.regions
                    .iter()
                    .map(|r| vk::ImageCopy {
                        src_subresource: r.layers(),
                        src_offset: vk::Offset3D {
                            x: r.src_offset[0],
                            y: r.src_offset[1],
                            z: r.src_offset[2],
                        },
                        dst_subresource: r.layers(),
                        dst_offset: vk::Offset3D {
                            x: r.dst_offset[0],
                            y: r.dst_offset[1],
                            z: r.dst_offset[2],
                        },
                        extent: partial_extent,
                    })
                    .collect()
            }
            _ => (0..copy_array_size)
                .map(|layer_ndx| vk::ImageCopy {
                    src_subresource: layers(0, 1),
                    src_offset: zero,
                    dst_subresource: layers(layer_ndx, 1),
                    dst_offset: zero,
                    extent,
                })
                .collect(),
        };

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, copy_array_size);
        let multisampled_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            p.src_layout,
            multisampled.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.array_size()),
        );
        let copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            p.dst_layout,
            copy_image.get(),
            subresource_range,
        );
        let copy_post_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::MEMORY_READ,
            p.dst_layout,
            p.src_layout,
            copy_image.get(),
            subresource_range,
        );

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[multisampled_barrier, copy_barrier],
            );
            device.cmd_copy_image(*cmd_buffer, multisampled.get(), p.src_layout, copy_image.get(), p.dst_layout, &image_copies);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[copy_post_barrier],
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;
        Ok(())
    }

    /// `ResolveImageToImage::checkIntermediateCopy` - a render pass that reads the
    /// source and every layer of the copy as multisampled subpass inputs and records,
    /// per pixel and per sample, whether they agree.
    fn check_intermediate_copy(&self, multisampled: &ImageWithMemory<'_>, copy_image: &ImageWithMemory<'_>) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let current_layout = p.src_layout;
        let num_dst_layers = p.dst.array_size();
        let num_input_attachments = p.num_input_attachments();
        let fb_width = p.src.extent[0];
        let fb_height = p.src.extent[1];
        let sample_count = p.samples.bits();

        let programs = p.verify_programs();
        let vert = create_shader_module(device, programs.get("vert")?)?;
        let verification = create_shader_module(device, programs.get("verify")?)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, num_input_attachments)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;

        let output_buffer_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let mut attachments_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..num_input_attachments {
            attachments_builder = attachments_builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
        }
        let input_attachments_set_layout = attachments_builder.build(device)?;

        let descriptor_set_buffer = make_descriptor_set(device, *descriptor_pool, *output_buffer_set_layout)?;
        let descriptor_set_attachments = make_descriptor_set(device, *descriptor_pool, *input_attachments_set_layout)?;

        let push_constant_data: [i32; 3] = [fb_width as i32, fb_height as i32, sample_count as i32];
        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of_val(&push_constant_data) as u32,
        };
        let set_layouts = [*output_buffer_set_layout, *input_attachments_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(std::slice::from_ref(&push_constant_range));
        let pipeline_layout = Unique::new(device, unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?);

        let render_pass = make_verification_render_pass(device, p.src.format, p.samples, num_input_attachments, current_layout)?;

        // Attachment 0 is the image the draw wrote; the rest are the copy's layers.
        let mut image_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
        if p.options == ResolveOptions::CopyMsImageLayerToMsImage {
            image_views.push(make_image_view(
                device,
                multisampled.get(),
                vk::ImageViewType::_2D,
                p.src.format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 2, 1),
            )?);
            image_views.push(make_image_view(
                device,
                copy_image.get(),
                vk::ImageViewType::_2D,
                p.src.format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 4, 1),
            )?);
        } else {
            image_views.push(make_image_view(
                device,
                multisampled.get(),
                vk::ImageViewType::_2D,
                p.src.format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?);
            for i in 0..num_dst_layers {
                image_views.push(make_image_view(
                    device,
                    copy_image.get(),
                    vk::ImageViewType::_2D,
                    p.dst.format,
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, i, 1),
                )?);
            }
        }
        let raw_views: Vec<vk::ImageView> = image_views.iter().map(|v| **v).collect();
        let framebuffer = make_framebuffer(device, *render_pass, &raw_views, fb_width, fb_height, 1)?;

        let buffer_count = (fb_width * fb_height * sample_count) as usize;
        let buffer_size = (buffer_count * std::mem::size_of::<i32>()) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        unsafe {
            let buffer_info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: buffer_size,
            };
            let image_infos: Vec<vk::DescriptorImageInfo> = raw_views
                .iter()
                .map(|v| vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: *v,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                })
                .collect();

            let mut writes = vec![vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set_buffer,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_info,
                texel_buffer_view: std::ptr::null(),
            }];
            for (i, info) in image_infos.iter().enumerate() {
                writes.push(vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: *descriptor_set_attachments,
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

        // `fullScreenQuad` - every framebuffer pixel and sample location is verified.
        let full_screen_quad: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
        ];
        let vertex_buffer = upload_vertices(device, allocator, &full_screen_quad)?;

        // Single-sampled: the shader loops over sample indices itself, which avoids
        // needing sampleRateShading.
        let graphics_pipeline = crate::vk::obj_util::make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vert,
            *verification,
            *render_pass,
            (fb_width, fb_height),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            0,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            let images_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::INPUT_ATTACHMENT_READ);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[images_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: fb_width,
                        height: fb_height,
                    },
                });
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

            // The load op counts as an attachment write, so the shader's read of the
            // same attachment needs the subpass self-dependency made explicit.
            let load_barrier = make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::COLOR_ATTACHMENT_READ);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::BY_REGION,
                &[load_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            let bytes = std::slice::from_raw_parts(push_constant_data.as_ptr().cast::<u8>(), std::mem::size_of_val(&push_constant_data));
            device.cmd_push_constants(*cmd_buffer, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, bytes);
            device.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set_buffer, *descriptor_set_attachments],
                &[],
            );
            device.cmd_draw(*cmd_buffer, full_screen_quad.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);

            let buffer_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[buffer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut output_flags = vec![0i32; buffer_count];
        unsafe {
            std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr().cast_const().cast::<i32>(), output_flags.as_mut_ptr(), buffer_count);
        }

        for x in 0..fb_width {
            for y in 0..fb_height {
                for s in 0..sample_count {
                    let index = ((y * fb_width + x) * sample_count + s) as usize;
                    if output_flags[index] == 0 {
                        return Ok(TestStatus::fail(format!("Intermediate verification failed for coordinates ({x}, {y}) sample {s}")));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `ResolveImageToImage::checkTestResult`
    fn check_test_result(&self, expected_level: &TextureLevel, result_level: &TextureLevel) -> TestStatus {
        let p = self.params;
        let expected = expected_level.get_const_access();
        let result = result_level.get_const_access();
        let [ew, eh, _] = expected.size();
        let [rw, rh, _] = result.size();

        if p.options == ResolveOptions::CopyMsImageLayerToMsImage {
            // Every layer but the copied one was resolved from a cleared white layer.
            for array_layer_ndx in 0..p.dst.array_size() - 1 {
                let result_sub = result.get_subregion(0, 0, array_layer_ndx, rw, rh, 1);
                if result_sub.get_pixel(0, 0, 0) != [1.0, 1.0, 1.0, 1.0] {
                    return TestStatus::fail("CopiesAndBlitting test. Layers image differs from initialized value.");
                }
            }
            let expected_sub = expected.get_subregion(0, 0, 2, ew, eh, 1);
            let result_sub = result.get_subregion(0, 0, 4, rw, rh, 1);
            return match fuzzy_compare_ok(&expected_sub, &result_sub, FUZZY_THRESHOLD) {
                Some(true) => TestStatus::pass("CopiesAndBlitting test"),
                Some(false) => TestStatus::fail("CopiesAndBlitting test"),
                None => TestStatus::fail("CopiesAndBlitting test: no fuzzy comparison for this format"),
            };
        }

        for array_layer_ndx in 0..p.dst.array_size() {
            let expected_sub = expected.get_subregion(0, 0, array_layer_ndx, ew, eh, 1);
            let result_sub = result.get_subregion(0, 0, array_layer_ndx, rw, rh, 1);
            match fuzzy_compare_ok(&expected_sub, &result_sub, FUZZY_THRESHOLD) {
                Some(true) => {}
                Some(false) => return TestStatus::fail("CopiesAndBlitting test"),
                None => return TestStatus::fail("CopiesAndBlitting test: no fuzzy comparison for this format"),
            }
        }
        TestStatus::pass("CopiesAndBlitting test")
    }
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

fn make_memory_barrier(src_access_mask: vk::AccessFlags, dst_access_mask: vk::AccessFlags) -> vk::MemoryBarrier {
    vk::MemoryBarrier {
        s_type: vk::StructureType::MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
    }
}

/// The render pass the source draw goes through. The attachment starts and ends in
/// `TRANSFER_DST_OPTIMAL`, which is what the pre-draw clear leaves it in and what every
/// later barrier expects to find.
fn make_resolve_render_pass(
    device: &Device,
    color_format: vk::Format,
    samples: vk::SampleCountFlags,
    use_subpass_dependency: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(samples)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
        .final_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL);
    let attachments = [attachment];

    let color_ref = vk::AttachmentReference::builder().attachment(0).layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    let color_refs = [color_ref];
    let subpass = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs);
    let subpasses = [subpass];

    // Synchronises the pre-draw clear against the colour attachment write.
    let dependency = vk::SubpassDependency::builder()
        .src_subpass(vk::SUBPASS_EXTERNAL)
        .dst_subpass(0)
        .src_stage_mask(vk::PipelineStageFlags::TRANSFER)
        .dst_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE);
    let dependencies = [dependency];

    let mut info = vk::RenderPassCreateInfo::builder().attachments(&attachments).subpasses(&subpasses);
    if use_subpass_dependency {
        info = info.dependencies(&dependencies);
    }
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// The verification pass: N multisampled input attachments, no colour and no
/// depth/stencil attachment - the shader only reads them and writes a buffer.
fn make_verification_render_pass(
    device: &Device,
    format: vk::Format,
    samples: vk::SampleCountFlags,
    count: u32,
    current_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments: Vec<vk::AttachmentDescription> = (0..count)
        .map(|_| {
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(current_layout)
                .final_layout(current_layout)
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

    // Self-dependency: the load op is considered to write the attachment the shader
    // then reads.
    let dependency = vk::SubpassDependency::builder()
        .src_subpass(0)
        .dst_subpass(0)
        .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
        .dst_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ)
        .dependency_flags(vk::DependencyFlags::BY_REGION);
    let dependencies = [dependency];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    Ok(Unique::new(device, unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?))
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

/// What every registration in this file varies, so that adding one is a table entry
/// rather than another copy of the sample-count loop.
struct ResolveGroupSpec<'a> {
    src_extent: [u32; 3],
    dst_extent: [u32; 3],
    src_layout: vk::ImageLayout,
    dst_layout: vk::ImageLayout,
    regions: &'a [ImageResolve],
    options: ResolveOptions,
    /// Prepended to the sample count - only `diff_image_size` uses it.
    name_prefix: &'a str,
    /// Appended to the sample count, before any `_bind_offset` suffix.
    name_suffix: &'a str,
    with_bind_offset: bool,
    needs_maintenance5: bool,
}

impl ResolveGroupSpec<'_> {
    fn default_with(regions: &[ImageResolve], options: ResolveOptions) -> ResolveGroupSpec<'_> {
        ResolveGroupSpec {
            src_extent: DEFAULT_EXTENT,
            dst_extent: DEFAULT_EXTENT,
            src_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            dst_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            regions,
            options,
            name_prefix: "",
            name_suffix: "",
            with_bind_offset: true,
            needs_maintenance5: false,
        }
    }
}

fn add_resolve_group(group: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind, spec: &ResolveGroupSpec<'_>) {
    for samples in SAMPLES {
        let make = |name: String, image_offset: bool| ResolveImageCase {
            name,
            src: resolve_parms(vk::Format::R8G8B8A8_UNORM, spec.src_extent),
            dst: resolve_parms(vk::Format::R8G8B8A8_UNORM, spec.dst_extent),
            src_layout: spec.src_layout,
            dst_layout: spec.dst_layout,
            regions: spec.regions.to_vec(),
            samples,
            options: spec.options,
            image_offset,
            needs_maintenance5: spec.needs_maintenance5,
            allocation_kind,
        };
        let base = format!("{}{}{}", spec.name_prefix, sample_count_case_name(samples), spec.name_suffix);
        group.add_child(Box::new(make(base.clone(), false)) as Box<dyn TestCase>);
        if spec.with_bind_offset && allocation_kind != AllocationKind::Dedicated {
            group.add_child(Box::new(make(format!("{base}_bind_offset"), true)) as Box<dyn TestCase>);
        }
    }
}

/// `addResolveImageTests`, minus `whole_copy_before_resolving_no_cab`, `_compute` and
/// `_transfer`.
pub fn add_resolve_image_tests(parent: &mut tcu::TestCaseGroup, allocation_kind: AllocationKind) {
    let mut group = tcu::TestCaseGroup::new("resolve_image");

    // `addResolveImageWholeTests`
    let mut whole = tcu::TestCaseGroup::new("whole");
    let whole_resolve = [ImageResolve::whole(RESOLVE_EXTENT)];
    add_resolve_group(
        &mut whole,
        allocation_kind,
        &ResolveGroupSpec {
            src_extent: RESOLVE_EXTENT,
            dst_extent: RESOLVE_EXTENT,
            ..ResolveGroupSpec::default_with(&whole_resolve, ResolveOptions::NoOptionalOperation)
        },
    );
    group.add_child(whole);

    // `addResolveImagePartialTests`
    let mut partial = tcu::TestCaseGroup::new("partial");
    let partial_resolve = [ImageResolve {
        base_array_layer: 0,
        layer_count: 1,
        src_offset: [0, 0, 0],
        dst_offset: [64, 64, 0],
        extent: [128, 128, 1],
    }];
    add_resolve_group(
        &mut partial,
        allocation_kind,
        &ResolveGroupSpec {
            src_extent: RESOLVE_EXTENT,
            dst_extent: RESOLVE_EXTENT,
            ..ResolveGroupSpec::default_with(&partial_resolve, ResolveOptions::NoOptionalOperation)
        },
    );
    group.add_child(partial);

    // `addResolveImageWithRegionsTests`
    let mut with_regions = tcu::TestCaseGroup::new("with_regions");
    let regions: Vec<ImageResolve> = (0..256)
        .step_by(64)
        .map(|i| ImageResolve {
            base_array_layer: 0,
            layer_count: 1,
            src_offset: [i, i, 0],
            dst_offset: [i, 0, 0],
            extent: [64, 64, 1],
        })
        .collect();
    add_resolve_group(
        &mut with_regions,
        allocation_kind,
        &ResolveGroupSpec {
            src_extent: RESOLVE_EXTENT,
            dst_extent: RESOLVE_EXTENT,
            with_bind_offset: false,
            ..ResolveGroupSpec::default_with(&regions, ResolveOptions::NoOptionalOperation)
        },
    );
    group.add_child(with_regions);

    // `addResolveImageWholeCopyBeforeResolvingTests`
    let default_resolve = [ImageResolve::whole(DEFAULT_EXTENT)];
    let mut whole_copy = tcu::TestCaseGroup::new("whole_copy_before_resolving");
    add_resolve_group(
        &mut whole_copy,
        allocation_kind,
        &ResolveGroupSpec::default_with(&default_resolve, ResolveOptions::CopyMsImageToMsImage),
    );
    group.add_child(whole_copy);

    // `addResolveImageWholeCopyDiffLayoutsBeforeResolvingTests`
    let mut diff_layouts = tcu::TestCaseGroup::new("diff_layout_copy_before_resolving");
    let image_layouts = [
        (vk::ImageLayout::GENERAL, "general"),
        (vk::ImageLayout::TRANSFER_SRC_OPTIMAL, "transfer_src_optimal"),
        (vk::ImageLayout::TRANSFER_DST_OPTIMAL, "transfer_dst_optimal"),
    ];
    for (src_layout, src_name) in image_layouts {
        for (dst_layout, dst_name) in image_layouts {
            if src_layout == vk::ImageLayout::TRANSFER_DST_OPTIMAL || dst_layout == vk::ImageLayout::TRANSFER_SRC_OPTIMAL {
                continue;
            }
            add_resolve_group(
                &mut diff_layouts,
                allocation_kind,
                &ResolveGroupSpec {
                    src_layout,
                    dst_layout,
                    name_suffix: &format!("_{src_name}_{dst_name}"),
                    ..ResolveGroupSpec::default_with(&default_resolve, ResolveOptions::CopyMsImageToMsImage)
                },
            );
        }
    }
    group.add_child(diff_layouts);

    // `addResolveImageLayerCopyBeforeResolvingTests` - five layers, of which only the
    // one the copy wrote holds the pattern.
    let mut layer_copy = tcu::TestCaseGroup::new("layer_copy_before_resolving");
    let layer_regions: Vec<ImageResolve> = (0..5)
        .map(|layer_ndx| ImageResolve {
            base_array_layer: layer_ndx,
            ..ImageResolve::whole(DEFAULT_EXTENT)
        })
        .collect();
    let five_layer_extent = [DEFAULT_EXTENT[0], DEFAULT_EXTENT[1], 5];
    add_resolve_group(
        &mut layer_copy,
        allocation_kind,
        &ResolveGroupSpec {
            src_extent: five_layer_extent,
            dst_extent: five_layer_extent,
            ..ResolveGroupSpec::default_with(&layer_regions, ResolveOptions::CopyMsImageLayerToMsImage)
        },
    );
    group.add_child(layer_copy);

    // `addResolveCopyImageWithRegionsTests` - two half-image regions, copied and then
    // resolved from where the copy put them.
    let mut copy_with_regions = tcu::TestCaseGroup::new("copy_with_regions_before_resolving");
    let image_half_width = (RESOLVE_EXTENT[0] / 2) as i32;
    let image_half_height = (RESOLVE_EXTENT[1] / 2) as i32;
    let half_image_extent = [RESOLVE_EXTENT[0] / 2, RESOLVE_EXTENT[1] / 2, 1];
    let multiregion = [
        // Lower right corner to lower left corner.
        ImageResolve {
            src_offset: [image_half_width, image_half_height, 0],
            dst_offset: [0, image_half_height, 0],
            extent: half_image_extent,
            ..ImageResolve::whole(half_image_extent)
        },
        // Upper right corner to lower right corner.
        ImageResolve {
            src_offset: [image_half_width, 0, 0],
            dst_offset: [image_half_width, image_half_height, 0],
            extent: half_image_extent,
            ..ImageResolve::whole(half_image_extent)
        },
    ];
    add_resolve_group(
        &mut copy_with_regions,
        allocation_kind,
        &ResolveGroupSpec {
            src_extent: RESOLVE_EXTENT,
            dst_extent: RESOLVE_EXTENT,
            ..ResolveGroupSpec::default_with(&multiregion, ResolveOptions::CopyMsImageToMsImageMultiregion)
        },
    );
    group.add_child(copy_with_regions);

    // `addResolveImageWholeArrayImageTests` - one source layer fanned out to five.
    let mut whole_array = tcu::TestCaseGroup::new("whole_array_image");
    let array_extent = [DEFAULT_EXTENT[0], DEFAULT_EXTENT[1], 5];
    add_resolve_group(
        &mut whole_array,
        allocation_kind,
        &ResolveGroupSpec {
            dst_extent: array_extent,
            ..ResolveGroupSpec::default_with(&layer_regions, ResolveOptions::CopyMsImageToArrayMsImage)
        },
    );
    group.add_child(whole_array);

    // `addResolveImageWholeArrayImageSingleRegionTests` - the same fan-out written as
    // one multi-layer region, including the two maintenance5 spellings of "the rest".
    let mut one_region = tcu::TestCaseGroup::new("whole_array_image_one_region");
    for (base_layer, layer_count, suffix, needs_maintenance5) in [
        (0u32, 5u32, "", false),
        (0, REMAINING_ARRAY_LAYERS, "_all_remaining_layers", true),
        (2, REMAINING_ARRAY_LAYERS, "_not_all_remaining_layers", true),
    ] {
        let single = [ImageResolve {
            base_array_layer: base_layer,
            layer_count,
            ..ImageResolve::whole(DEFAULT_EXTENT)
        }];
        add_resolve_group(
            &mut one_region,
            allocation_kind,
            &ResolveGroupSpec {
                dst_extent: array_extent,
                name_suffix: suffix,
                needs_maintenance5,
                ..ResolveGroupSpec::default_with(&single, ResolveOptions::CopyMsImageToArrayMsImage)
            },
        );
    }
    group.add_child(one_region);

    // `addResolveImageDiffImageSizeTests` - the region stays the full resolveExtent
    // while one side's image is made larger in one axis.
    let mut diff_size = tcu::TestCaseGroup::new("diff_image_size");
    let image_extents = [
        [RESOLVE_EXTENT[0] + 10, RESOLVE_EXTENT[1], RESOLVE_EXTENT[2]],
        [RESOLVE_EXTENT[0], RESOLVE_EXTENT[1] * 2, RESOLVE_EXTENT[2]],
        [RESOLVE_EXTENT[0], RESOLVE_EXTENT[1], RESOLVE_EXTENT[2] + 10],
    ];
    // Only the destination half gets the bind-offset variant upstream.
    for (prefix, vary_src, with_bind_offset) in [("src", true, false), ("dst", false, true)] {
        for extent in image_extents {
            let (src_extent, dst_extent) = if vary_src { (extent, RESOLVE_EXTENT) } else { (RESOLVE_EXTENT, extent) };
            add_resolve_group(
                &mut diff_size,
                allocation_kind,
                &ResolveGroupSpec {
                    src_extent,
                    dst_extent,
                    with_bind_offset,
                    name_prefix: &format!("{prefix}_{}_{}_{}_", extent[0], extent[1], extent[2]),
                    ..ResolveGroupSpec::default_with(&whole_resolve, ResolveOptions::NoOptionalOperation)
                },
            );
        }
    }
    group.add_child(diff_size);

    parent.add_child(group);
}
