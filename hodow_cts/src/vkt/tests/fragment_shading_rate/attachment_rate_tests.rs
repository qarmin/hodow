// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_rate/vktAttachmentRateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/fragment_shading_rate_attachment_rate.toml, one set
// per mode family and rate value (`programs_key`). `AttachmentRateInstance` is `Fixture`, which owns the objects its `run*` methods share;
// the two modes that submit to a separate transfer queue run it on `Context::multi_queue_device()`, which stands in for the custom device
// upstream creates with the fragment shading rate attachment feature only. The error mask images of `verifyUsingAtomicChecks` are not
// logged, only the counts.
//
// The rate of a shading rate attachment is set up in six ways (an atomic add from a compute shader, a render pass drawing it, a copy from
// another image, a copy on a transfer queue of either sharing mode and a linear tiled image written by the host), a triangle is then drawn
// with it and every fragment must have the rate and share its atomic counter value with the other fragments of the same rate block.

use std::collections::BTreeMap;
use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrCreateRenderpass2ExtensionDeviceCommands};

use super::basic_tests::sr_fill_pixel_size;
use super::{GroupParams, fragment_shading_rate_features, supported_fragment_shading_rates};
use crate::generated::shaders::fragment_shading_rate_attachment_rate::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier,
};
use crate::vk::pipeline_construction::PipelineConstructionType;
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const CB_WIDTH: u32 = 60;
const CB_HEIGHT: u32 = 60;
const CB_FORMAT: vk::Format = vk::Format::R32G32B32A32_UINT;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    SetupRateWithAtomicsInComputeShader,
    SetupRateWithFragmentShader,
    SetupRateWithCopyingFromOtherImage,
    SetupRateWithCopyingFromExclusiveImageUsingTransferQueue,
    SetupRateWithCopyingFromConcurrentImageUsingTransferQueue,
    SetupRateWithLinearTiledImage,
    TwoSubpass,
    MemoryAccess,
    Maintenance5,
}

#[derive(Clone, Copy)]
struct DepthStencilParams {
    format: vk::Format,
    layout: vk::ImageLayout,
}

#[derive(Clone, Copy)]
struct TestParams {
    mode: TestMode,
    sr_format: vk::Format,
    sr_rate: vk::Extent2D,
    use_dynamic_rendering: bool,
    use_imageless_framebuffer: bool,
    use_null_shading_rate_image: bool,
    use_general_layout: bool,
    ds_params: Option<DepthStencilParams>,
}

impl TestParams {
    fn use_depth_stencil(&self) -> bool {
        self.ds_params.is_some_and(|ds| ds.format != vk::Format::UNDEFINED)
    }

    /// The depth/stencil format, or `VK_FORMAT_UNDEFINED` if not present.
    fn ds_format(&self) -> vk::Format {
        self.ds_params.map_or(vk::Format::UNDEFINED, |ds| ds.format)
    }

    /// The depth/stencil layout, or `VK_IMAGE_LAYOUT_UNDEFINED` if not present.
    fn ds_layout(&self) -> vk::ImageLayout {
        self.ds_params.map_or(vk::ImageLayout::UNDEFINED, |ds| ds.layout)
    }
}

fn ds_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
}

/// `getFormatAspectFlags`
fn get_format_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::UNDEFINED => vk::ImageAspectFlags::empty(),
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => vk::ImageAspectFlags::DEPTH,
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        }
        _ => vk::ImageAspectFlags::COLOR,
    }
}

/// `calculateRate`
fn calculate_rate(rate_width: u32, rate_height: u32) -> u32 {
    (rate_width.trailing_zeros() << 2) | rate_height.trailing_zeros()
}

/// The key of the manifest entry of a mode family.
fn programs_key(params: &TestParams) -> String {
    let rate = calculate_rate(params.sr_rate.width.max(1), params.sr_rate.height.max(1));
    match params.mode {
        TestMode::SetupRateWithAtomicsInComputeShader => format!("ar_atomics_{rate}"),
        TestMode::SetupRateWithFragmentShader | TestMode::MemoryAccess | TestMode::Maintenance5 => {
            format!("ar_setup_{rate}")
        }
        TestMode::TwoSubpass => "ar_two_subpass".to_string(),
        _ => "ar_plain".to_string(),
    }
}

struct AttachmentRateCase {
    name: String,
    params: TestParams,
}

impl TestCase for AttachmentRateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `AttachmentRateTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        context.require_device_functionality("VK_KHR_fragment_shading_rate")?;

        if params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if params.use_imageless_framebuffer {
            context.require_device_functionality("VK_KHR_imageless_framebuffer")?;
        }

        if fragment_shading_rate_features(context).attachment_fragment_shading_rate == vk::FALSE {
            return Err(TestError::NotSupported(
                "attachmentFragmentShadingRate not supported".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let sr_usage = vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR | vk::ImageUsageFlags::TRANSFER_DST;
        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                params.sr_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                sr_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if result == Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if params.mode != TestMode::TwoSubpass {
            let tested_rate = params.sr_rate;
            // check if rate required by test is not supported
            let supported_fragment_shading_rates = supported_fragment_shading_rates(context);
            if !supported_fragment_shading_rates.iter().any(|rate| {
                rate.fragment_size.width == tested_rate.width && rate.fragment_size.height == tested_rate.height
            }) {
                return Err(TestError::NotSupported("Rate not supported".to_string()));
            }
        }

        if params.mode == TestMode::Maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        let required_features = match params.mode {
            TestMode::SetupRateWithAtomicsInComputeShader => {
                vk::FormatFeatureFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR
                    | vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC
            }
            TestMode::SetupRateWithCopyingFromOtherImage
            | TestMode::SetupRateWithCopyingFromExclusiveImageUsingTransferQueue
            | TestMode::SetupRateWithCopyingFromConcurrentImageUsingTransferQueue
            | TestMode::SetupRateWithLinearTiledImage => vk::FormatFeatureFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
            TestMode::SetupRateWithFragmentShader => {
                vk::FormatFeatureFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR | vk::FormatFeatureFlags::COLOR_ATTACHMENT
            }
            _ => vk::FormatFeatureFlags::empty(),
        };

        if !required_features.is_empty() {
            let format_properties =
                unsafe { instance.get_physical_device_format_properties(physical_device, params.sr_format) };
            let available = if params.mode == TestMode::SetupRateWithLinearTiledImage {
                format_properties.linear_tiling_features
            } else {
                format_properties.optimal_tiling_features
            };
            if !available.contains(required_features) {
                return Err(TestError::NotSupported(
                    "Required format feature bits not supported".to_string(),
                ));
            }
        }

        if params.use_depth_stencil() {
            let ds_format = params.ds_format();
            let ds_format_properties =
                unsafe { instance.get_physical_device_format_properties(physical_device, ds_format) };
            if !ds_format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
            {
                return Err(TestError::NotSupported(format!("{ds_format:?} not supported")));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = programs_key(&self.params);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AttachmentRateInstance {
            context,
            params: self.params,
        })
    }
}

/// `FBAttachmentInfo` - what `buildFramebuffer` needs to build a regular or an imageless framebuffer.
#[derive(Clone, Copy)]
struct FbAttachment {
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    width: u32,
    height: u32,
    view: vk::ImageView,
}

struct AttachmentRateInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl<'a> TestInstance for AttachmentRateInstance<'a> {
    /// `AttachmentRateInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let multi_queue_device;
        let passed = match params.mode {
            TestMode::SetupRateWithCopyingFromExclusiveImageUsingTransferQueue
            | TestMode::SetupRateWithCopyingFromConcurrentImageUsingTransferQueue => {
                multi_queue_device = context.multi_queue_device()?;
                let mut fixture = Fixture::new(
                    context,
                    params,
                    multi_queue_device.device(),
                    multi_queue_device.allocator(),
                    context.get_universal_queue_family_index(),
                    context.get_universal_queue(),
                );
                fixture.run_copy_mode_on_transfer_queue(multi_queue_device.families())?
            }
            _ => {
                let mut fixture = Fixture::new(
                    context,
                    params,
                    context.get_device(),
                    context.get_default_allocator(),
                    context.get_universal_queue_family_index(),
                    context.get_universal_queue(),
                );
                match params.mode {
                    TestMode::SetupRateWithAtomicsInComputeShader => fixture.run_compute_shader_mode()?,
                    TestMode::SetupRateWithFragmentShader | TestMode::MemoryAccess | TestMode::Maintenance5 => {
                        fixture.run_fragment_shader_mode()?
                    }
                    TestMode::SetupRateWithCopyingFromOtherImage => fixture.run_copy_mode()?,
                    TestMode::SetupRateWithLinearTiledImage => fixture.run_fill_linear_tiled_image()?,
                    TestMode::TwoSubpass => fixture.run_two_subpass_mode()?,
                    TestMode::SetupRateWithCopyingFromExclusiveImageUsingTransferQueue
                    | TestMode::SetupRateWithCopyingFromConcurrentImageUsingTransferQueue => unreachable!(),
                }
            }
        };

        Ok(if passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// The objects the modes of `AttachmentRateInstance` share.
struct Fixture<'d, 'c> {
    context: &'c Context<'c>,
    device: &'d Device,
    allocator: &'d SimpleAllocator,
    queue_family_index: u32,
    queue: vk::Queue,
    params: TestParams,
    cb_usage: vk::ImageUsageFlags,
    sr_usage: vk::ImageUsageFlags,
    min_tile_size: vk::Extent2D,
    max_tile_size: vk::Extent2D,
    max_aspect_ratio: u32,
    cb_image: [Option<ImageWithMemory<'d>>; 2],
    cb_image_view: [Option<Unique<'d, vk::ImageView>>; 2],
    cb_read_buffer: [Option<BufferWithMemory<'d>>; 2],
    ds_image: Option<ImageWithMemory<'d>>,
    ds_image_view: Option<Unique<'d, vk::ImageView>>,
    sr_image: [Option<ImageWithMemory<'d>>; 2],
    sr_image_view: [Option<Unique<'d, vk::ImageView>>; 2],
    counter_buffer_descriptor_set_layout: Option<Unique<'d, vk::DescriptorSetLayout>>,
    counter_buffer_descriptor_set: Option<UniqueDescriptorSet<'d>>,
    counter_buffer_descriptor_pool: Option<Unique<'d, vk::DescriptorPool>>,
    counter_buffer: Option<BufferWithMemory<'d>>,
}

fn default_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

fn default_buffer_image_copy() -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: CB_WIDTH,
            height: CB_HEIGHT,
            depth: 1,
        },
    }
}

fn pipeline_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    memory_barriers: &[vk::MemoryBarrier],
    image_barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            memory_barriers,
            &[] as &[vk::BufferMemoryBarrier],
            image_barriers,
        )
    };
}

impl<'d, 'c> Fixture<'d, 'c> {
    fn new(
        context: &'c Context<'c>,
        params: TestParams,
        device: &'d Device,
        allocator: &'d SimpleAllocator,
        queue_family_index: u32,
        queue: vk::Queue,
    ) -> Self {
        // prepare data needed to calculate tile sizes
        let sr_properties = super::fragment_shading_rate_properties(context);
        Self {
            context,
            device,
            allocator,
            queue_family_index,
            queue,
            params,
            cb_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            sr_usage: vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR | vk::ImageUsageFlags::TRANSFER_DST,
            min_tile_size: sr_properties.min_fragment_shading_rate_attachment_texel_size,
            max_tile_size: sr_properties.max_fragment_shading_rate_attachment_texel_size,
            max_aspect_ratio: sr_properties.max_fragment_shading_rate_attachment_texel_size_aspect_ratio,
            cb_image: [None, None],
            cb_image_view: [None, None],
            cb_read_buffer: [None, None],
            ds_image: None,
            ds_image_view: None,
            sr_image: [None, None],
            sr_image_view: [None, None],
            counter_buffer_descriptor_set_layout: None,
            counter_buffer_descriptor_pool: None,
            counter_buffer_descriptor_set: None,
            counter_buffer: None,
        }
    }

    /// `getFsrLayout`
    fn fsr_layout(&self) -> vk::ImageLayout {
        if self.params.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR
        }
    }

    /// The tile sizes of the loops of every mode, without those whose aspect ratio is not supported.
    fn tile_sizes(&self) -> Vec<(u32, u32)> {
        let mut sizes = Vec::new();
        let mut tile_width = self.min_tile_size.width;
        while tile_width <= self.max_tile_size.width {
            let mut tile_height = self.min_tile_size.height;
            while tile_height <= self.max_tile_size.height {
                let aspect_ratio = if tile_height > tile_width {
                    tile_height / tile_width
                } else {
                    tile_width / tile_height
                };
                if aspect_ratio <= self.max_aspect_ratio {
                    sizes.push((tile_width, tile_height));
                }
                tile_height *= 2;
            }
            tile_width *= 2;
        }
        sizes
    }

    fn cb_view(&self, index: usize) -> vk::ImageView {
        self.cb_image_view[index]
            .as_ref()
            .map_or_else(vk::ImageView::null, |view| **view)
    }

    fn sr_view(&self, index: usize) -> vk::ImageView {
        self.sr_image_view[index]
            .as_ref()
            .map_or_else(vk::ImageView::null, |view| **view)
    }

    fn cb_image_handle(&self, index: usize) -> vk::Image {
        self.cb_image[index]
            .as_ref()
            .map_or_else(vk::Image::null, |image| image.get())
    }

    fn sr_image_handle(&self, index: usize) -> vk::Image {
        self.sr_image[index]
            .as_ref()
            .map_or_else(vk::Image::null, |image| image.get())
    }

    /// `buildImageWithMemory`
    fn build_image_with_memory(
        &self,
        format: vk::Format,
        width: u32,
        height: u32,
        usage: vk::ImageUsageFlags,
        tiling: vk::ImageTiling,
        queue_families: &[u32],
    ) -> Result<ImageWithMemory<'d>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width,
                height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(tiling)
            .usage(usage)
            .sharing_mode(if queue_families.is_empty() {
                vk::SharingMode::EXCLUSIVE
            } else {
                vk::SharingMode::CONCURRENT
            })
            .queue_family_indices(queue_families)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let memory_requirement = if tiling == vk::ImageTiling::LINEAR {
            MemoryRequirement::HOST_VISIBLE
        } else {
            MemoryRequirement::ANY
        };
        ImageWithMemory::new(self.device, self.allocator, info, memory_requirement)
    }

    /// `buildBufferWithMemory`
    fn build_buffer_with_memory(
        &self,
        size: u32,
        usage: vk::BufferUsageFlags,
    ) -> Result<BufferWithMemory<'d>, TestError> {
        BufferWithMemory::new(
            self.device,
            self.allocator,
            make_buffer_create_info(vk::DeviceSize::from(size), usage),
            MemoryRequirement::HOST_VISIBLE,
        )
    }

    /// `buildImageView`
    fn build_image_view(&self, format: vk::Format, image: vk::Image) -> Result<Unique<'d, vk::ImageView>, TestError> {
        let subresource_range = make_image_subresource_range(get_format_aspect_flags(format), 0, 1, 0, 1);
        crate::vk::image_util::make_image_view(self.device, image, vk::ImageViewType::_2D, format, subresource_range)
    }

    /// `buildColorBufferObjects`
    fn build_color_buffer_objects(&mut self, index: usize, usage: vk::ImageUsageFlags) -> Result<(), TestError> {
        let image =
            self.build_image_with_memory(CB_FORMAT, CB_WIDTH, CB_HEIGHT, usage, vk::ImageTiling::OPTIMAL, &[])?;
        self.cb_image_view[index] = Some(self.build_image_view(CB_FORMAT, image.get())?);
        self.cb_image[index] = Some(image);
        self.cb_read_buffer[index] =
            Some(self.build_buffer_with_memory(CB_WIDTH * CB_HEIGHT * 4 * 4, vk::BufferUsageFlags::TRANSFER_DST)?);

        if self.params.use_depth_stencil() && self.ds_image.is_none() {
            let ds_format = self.params.ds_format();
            let ds_image = self.build_image_with_memory(
                ds_format,
                CB_WIDTH,
                CB_HEIGHT,
                ds_usage(),
                vk::ImageTiling::OPTIMAL,
                &[],
            )?;
            self.ds_image_view = Some(self.build_image_view(ds_format, ds_image.get())?);
            self.ds_image = Some(ds_image);
        }
        Ok(())
    }

    /// `buildShadingRateObjects`
    fn build_shading_rate_objects(
        &mut self,
        index: usize,
        width: u32,
        height: u32,
        usage: vk::ImageUsageFlags,
        tiling: vk::ImageTiling,
    ) -> Result<(), TestError> {
        let image = self.build_image_with_memory(self.params.sr_format, width, height, usage, tiling, &[])?;
        self.sr_image_view[index] = Some(self.build_image_view(self.params.sr_format, image.get())?);
        self.sr_image[index] = Some(image);
        Ok(())
    }

    /// `buildCounterBufferObjects`
    fn build_counter_buffer_objects(&mut self) -> Result<(), TestError> {
        let device = self.device;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let set = make_descriptor_set(device, *pool, *layout)?;

        // create ssbo buffer for atomic counter
        let ssbo_size = std::mem::size_of::<u32>() as u32;
        let buffer = self.build_buffer_with_memory(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        let descriptor_info = [vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: vk::DeviceSize::from(ssbo_size),
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(set.get())
            .dst_binding(0)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&descriptor_info);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // reset counter
        unsafe { std::ptr::write(buffer.get_allocation().get_host_ptr().cast::<u32>(), 0) };
        flush_alloc(device, buffer.get_allocation())?;

        self.counter_buffer_descriptor_pool = Some(pool);
        self.counter_buffer_descriptor_set_layout = Some(layout);
        self.counter_buffer_descriptor_set = Some(set);
        self.counter_buffer = Some(buffer);
        Ok(())
    }

    fn counter_layout(&self) -> vk::DescriptorSetLayout {
        self.counter_buffer_descriptor_set_layout
            .as_ref()
            .map_or_else(vk::DescriptorSetLayout::null, |layout| **layout)
    }

    fn counter_set(&self) -> vk::DescriptorSet {
        self.counter_buffer_descriptor_set
            .as_ref()
            .map_or_else(vk::DescriptorSet::null, |set| set.get())
    }

    /// `buildRenderPass` - none for dynamic rendering.
    fn build_render_pass(
        &self,
        cb_format: vk::Format,
        ds_format: vk::Format,
        sr0_tile: (u32, u32),
        sr1_tile: (u32, u32),
    ) -> Result<Option<Unique<'d, vk::RenderPass>>, TestError> {
        if self.params.use_dynamic_rendering {
            return Ok(None);
        }

        let use_shading_rate0 = sr0_tile.0 * sr0_tile.1 > 0;
        let use_shading_rate1 = sr1_tile.0 * sr1_tile.1 > 0;
        let mut attachment_count = 1u32;
        let subpass_count = 1 + usize::from(use_shading_rate1);
        let fsr_layout = self.fsr_layout();

        let mut color_attachment_references = vec![
            vk::AttachmentReference2 {
                attachment: 0,
                layout: vk::ImageLayout::GENERAL,
                aspect_mask: vk::ImageAspectFlags::empty(),
                ..Default::default()
            };
            subpass_count
        ];
        let mut fragment_shading_rate_attachments = vec![
            vk::AttachmentReference2 {
                attachment: 1,
                layout: fsr_layout,
                aspect_mask: vk::ImageAspectFlags::empty(),
                ..Default::default()
            };
            subpass_count
        ];
        let template_description = vk::AttachmentDescription2 {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: cb_format,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::CLEAR,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::GENERAL,
            final_layout: vk::ImageLayout::GENERAL,
            ..Default::default()
        };
        let mut attachment_descriptions = vec![template_description; 2 * subpass_count];
        let mut texel_sizes = [
            vk::Extent2D {
                width: sr0_tile.0,
                height: sr0_tile.1,
            },
            vk::Extent2D { width: 0, height: 0 },
        ];

        if use_shading_rate0 {
            attachment_count = 2;
            attachment_descriptions[1].format = self.params.sr_format;
            attachment_descriptions[1].load_op = vk::AttachmentLoadOp::LOAD;
            attachment_descriptions[1].store_op = vk::AttachmentStoreOp::DONT_CARE;
            attachment_descriptions[1].initial_layout = fsr_layout;
        }

        if use_shading_rate1 {
            attachment_count = 4;
            color_attachment_references[1].attachment = 2;
            fragment_shading_rate_attachments[1].attachment = 3;
            texel_sizes[1] = vk::Extent2D {
                width: sr1_tile.0,
                height: sr1_tile.1,
            };
            attachment_descriptions[3].format = self.params.sr_format;
            attachment_descriptions[3].load_op = vk::AttachmentLoadOp::LOAD;
            attachment_descriptions[3].store_op = vk::AttachmentStoreOp::DONT_CARE;
            attachment_descriptions[3].initial_layout = fsr_layout;
        }

        let mut ds_attachment_references: Vec<vk::AttachmentReference2> = Vec::new();
        if ds_format != vk::Format::UNDEFINED {
            let ds_layout = self.params.ds_layout();
            let ds_aspects = get_format_aspect_flags(ds_format);
            let has_depth = ds_aspects.contains(vk::ImageAspectFlags::DEPTH);
            let has_stencil = ds_aspects.contains(vk::ImageAspectFlags::STENCIL);
            attachment_count += 1;
            attachment_descriptions.push(vk::AttachmentDescription2 {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: ds_format,
                samples: vk::SampleCountFlags::_1,
                load_op: if has_depth {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                },
                store_op: if has_depth {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                },
                stencil_load_op: if has_stencil {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                },
                stencil_store_op: if has_stencil {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                },
                initial_layout: ds_layout,
                final_layout: ds_layout,
                ..Default::default()
            });
            ds_attachment_references.push(vk::AttachmentReference2 {
                attachment: attachment_count - 1,
                layout: ds_layout,
                aspect_mask: vk::ImageAspectFlags::empty(),
                ..Default::default()
            });
        }

        let shading_rate_attachment_infos: Vec<vk::FragmentShadingRateAttachmentInfoKHR> = (0..subpass_count)
            .map(|subpass| vk::FragmentShadingRateAttachmentInfoKHR {
                fragment_shading_rate_attachment: &fragment_shading_rate_attachments[subpass],
                shading_rate_attachment_texel_size: texel_sizes[subpass],
                ..Default::default()
            })
            .collect();
        let subpass_descriptions: Vec<vk::SubpassDescription2> = (0..subpass_count)
            .map(|subpass| {
                let uses_shading_rate = (subpass == 0 && use_shading_rate0) || (subpass == 1 && use_shading_rate1);
                vk::SubpassDescription2 {
                    next: if uses_shading_rate {
                        (&shading_rate_attachment_infos[subpass] as *const vk::FragmentShadingRateAttachmentInfoKHR)
                            .cast::<c_void>()
                    } else {
                        std::ptr::null()
                    },
                    flags: vk::SubpassDescriptionFlags::empty(),
                    pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                    view_mask: 0,
                    input_attachment_count: 0,
                    input_attachments: std::ptr::null(),
                    color_attachment_count: 1,
                    color_attachments: &color_attachment_references[subpass],
                    resolve_attachments: std::ptr::null(),
                    depth_stencil_attachment: ds_attachment_references.last().map_or(std::ptr::null(), |reference| {
                        reference as *const vk::AttachmentReference2
                    }),
                    preserve_attachment_count: 0,
                    preserve_attachments: std::ptr::null(),
                    ..Default::default()
                }
            })
            .collect();

        let render_pass_params = vk::RenderPassCreateInfo2 {
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count,
            attachments: attachment_descriptions.as_ptr(),
            subpass_count: subpass_count as u32,
            subpasses: subpass_descriptions.as_ptr(),
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
            ..Default::default()
        };
        let handle = unsafe { self.device.create_render_pass2_khr(&render_pass_params, None) }
            .vk_check("vkCreateRenderPass2KHR")?;
        Ok(Some(Unique::new(self.device, handle)))
    }

    /// `buildFramebuffer` - none for dynamic rendering.
    fn build_framebuffer(
        &self,
        render_pass: vk::RenderPass,
        attachment_info: &[FbAttachment],
    ) -> Result<Option<Unique<'d, vk::Framebuffer>>, TestError> {
        if self.params.use_dynamic_rendering {
            return Ok(None);
        }

        let attachments: Vec<vk::ImageView> = attachment_info.iter().map(|attachment| attachment.view).collect();
        let framebuffer_attachment_image_info: Vec<vk::FramebufferAttachmentImageInfo> = attachment_info
            .iter()
            .map(|attachment| vk::FramebufferAttachmentImageInfo {
                flags: vk::ImageCreateFlags::empty(),
                usage: attachment.usage,
                width: attachment.width,
                height: attachment.height,
                layer_count: 1,
                view_format_count: 1,
                view_formats: &attachment.format,
                ..Default::default()
            })
            .collect();
        let framebuffer_attachments_create_info = vk::FramebufferAttachmentsCreateInfo {
            attachment_image_info_count: framebuffer_attachment_image_info.len() as u32,
            attachment_image_infos: framebuffer_attachment_image_info.as_ptr(),
            ..Default::default()
        };

        let imageless = self.params.use_imageless_framebuffer;
        let framebuffer_params = vk::FramebufferCreateInfo {
            next: if imageless {
                (&framebuffer_attachments_create_info as *const vk::FramebufferAttachmentsCreateInfo).cast::<c_void>()
            } else {
                std::ptr::null()
            },
            flags: if imageless {
                vk::FramebufferCreateFlags::IMAGELESS
            } else {
                vk::FramebufferCreateFlags::empty()
            },
            render_pass,
            attachment_count: attachment_info.len() as u32,
            attachments: if imageless {
                std::ptr::null()
            } else {
                attachments.as_ptr()
            },
            width: attachment_info[0].width,
            height: attachment_info[0].height,
            layers: 1,
            ..Default::default()
        };
        let framebuffer =
            unsafe { self.device.create_framebuffer(&framebuffer_params, None) }.vk_check("vkCreateFramebuffer")?;
        Ok(Some(Unique::new(self.device, framebuffer)))
    }

    /// `buildPipelineLayout`
    fn build_pipeline_layout(
        &self,
        set_layout: Option<vk::DescriptorSetLayout>,
    ) -> Result<Unique<'d, vk::PipelineLayout>, TestError> {
        let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.into_iter().collect();
        let info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        Ok(Unique::new(
            self.device,
            unsafe { self.device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
        ))
    }

    /// `buildGraphicsPipeline`
    #[allow(clippy::too_many_arguments)]
    fn build_graphics_pipeline(
        &self,
        subpass: u32,
        render_pass: vk::RenderPass,
        cb_format: vk::Format,
        ds_format: vk::Format,
        pipeline_layout: vk::PipelineLayout,
        vert_shader: vk::ShaderModule,
        frag_shader: vk::ShaderModule,
        use_shading_rate: bool,
    ) -> Result<Unique<'d, vk::Pipeline>, TestError> {
        let ds_aspects = get_format_aspect_flags(ds_format);
        let has_depth = ds_aspects.contains(vk::ImageAspectFlags::DEPTH);
        let has_stencil = ds_aspects.contains(vk::ImageAspectFlags::STENCIL);
        let depth_compare_op = if has_depth {
            vk::CompareOp::ALWAYS
        } else {
            vk::CompareOp::LESS_OR_EQUAL
        };
        let stencil_compare_op = if has_stencil {
            vk::CompareOp::ALWAYS
        } else {
            vk::CompareOp::NEVER
        };

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(CB_WIDTH, CB_HEIGHT);
        state.rasterization = vk::PipelineRasterizationStateCreateInfo {
            depth_clamp_enable: vk::FALSE,
            rasterizer_discard_enable: vk::FALSE,
            polygon_mode: vk::PolygonMode::FILL,
            cull_mode: vk::CullModeFlags::NONE,
            front_face: vk::FrontFace::COUNTER_CLOCKWISE,
            depth_bias_enable: vk::FALSE,
            line_width: 1.0,
            ..Default::default()
        };
        let stencil_op_state = vk::StencilOpState {
            fail_op: vk::StencilOp::KEEP,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::KEEP,
            compare_op: stencil_compare_op,
            compare_mask: 0,
            write_mask: 0,
            reference: 0,
        };
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo {
            depth_test_enable: vk::Bool32::from(has_depth),
            depth_write_enable: vk::FALSE,
            depth_compare_op,
            depth_bounds_test_enable: vk::FALSE,
            stencil_test_enable: vk::Bool32::from(has_stencil),
            front: stencil_op_state,
            back: stencil_op_state,
            min_depth_bounds: 0.0,
            max_depth_bounds: 1.0,
            ..Default::default()
        };
        state.subpass = subpass;
        if use_shading_rate {
            state.fragment_shading_rate_state = Some(vk::PipelineFragmentShadingRateStateCreateInfoKHR {
                fragment_size: vk::Extent2D { width: 1, height: 1 },
                combiner_ops: [
                    vk::FragmentShadingRateCombinerOpKHR::KEEP,
                    vk::FragmentShadingRateCombinerOpKHR::REPLACE,
                ],
                ..Default::default()
            });
        }
        if self.params.use_dynamic_rendering {
            state.rendering_format = Some(cb_format);
            state.depth_rendering_format = ds_format;
            state.stencil_rendering_format = vk::Format::UNDEFINED;
        }
        if use_shading_rate && self.params.use_dynamic_rendering {
            if self.params.mode == TestMode::Maintenance5 {
                state.create_flags2 = Some(vk::PipelineCreateFlags2::RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR);
            } else {
                state.create_flags |= vk::PipelineCreateFlags::RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR;
            }
        }
        state.construction = PipelineConstructionType::Monolithic;

        create_draw_pipeline(
            self.device,
            pipeline_layout,
            render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, vert_shader),
                (vk::ShaderStageFlags::FRAGMENT, frag_shader),
            ],
            &state,
        )
    }

    /// `buildComputePipeline`
    fn build_compute_pipeline(
        &self,
        comp_shader: vk::ShaderModule,
        pipeline_layout: vk::PipelineLayout,
    ) -> Result<Unique<'d, vk::Pipeline>, TestError> {
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(comp_shader)
            .name(b"main\0");
        let create_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(pipeline_layout)
            .base_pipeline_index(0);
        let pipelines = unsafe {
            self.device
                .create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None)
        }
        .vk_check("vkCreateComputePipelines")?;
        Ok(Unique::new(self.device, pipelines.0[0]))
    }

    /// `startRendering`
    fn start_rendering(
        &self,
        cmd: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        render_area: vk::Rect2D,
        attachment_info: &[FbAttachment],
        sr_tile: (u32, u32),
    ) {
        let device = self.device;
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue { uint32: [0, 0, 0, 0] },
        };

        if self.params.use_dynamic_rendering {
            let mut shading_rate_attachment_info = vk::RenderingFragmentShadingRateAttachmentInfoKHR {
                image_view: vk::ImageView::null(),
                image_layout: self.fsr_layout(),
                shading_rate_attachment_texel_size: vk::Extent2D { width: 0, height: 0 },
                ..Default::default()
            };
            let color_attachment = vk::RenderingAttachmentInfo {
                image_view: attachment_info[0].view,
                image_layout: vk::ImageLayout::GENERAL,
                resolve_mode: vk::ResolveModeFlags::NONE,
                resolve_image_view: vk::ImageView::null(),
                resolve_image_layout: vk::ImageLayout::UNDEFINED,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                clear_value: clear_color,
                ..Default::default()
            };
            let mut rendering_info = vk::RenderingInfo {
                flags: vk::RenderingFlags::empty(),
                render_area,
                layer_count: 1,
                view_mask: 0,
                color_attachment_count: 1,
                color_attachments: &color_attachment,
                depth_attachment: std::ptr::null(),
                stencil_attachment: std::ptr::null(),
                ..Default::default()
            };

            // when shading rate is used it is defined as a second entry in attachmentInfo
            if attachment_info.len() == 2
                && attachment_info[1]
                    .usage
                    .contains(vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR)
            {
                if !self.params.use_null_shading_rate_image {
                    shading_rate_attachment_info.image_view = attachment_info[1].view;
                }
                shading_rate_attachment_info.shading_rate_attachment_texel_size = vk::Extent2D {
                    width: sr_tile.0,
                    height: sr_tile.1,
                };
                rendering_info.next = (&shading_rate_attachment_info
                    as *const vk::RenderingFragmentShadingRateAttachmentInfoKHR)
                    .cast::<c_void>();
            }

            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            return;
        }

        let attachments: Vec<vk::ImageView> = attachment_info.iter().map(|attachment| attachment.view).collect();
        let render_pass_attachment_begin_info = vk::RenderPassAttachmentBeginInfo {
            attachment_count: attachments.len() as u32,
            attachments: attachments.as_ptr(),
            ..Default::default()
        };
        let clear_values = vec![clear_color; attachment_info.len()];
        let begin_info = vk::RenderPassBeginInfo {
            next: if self.params.use_imageless_framebuffer {
                (&render_pass_attachment_begin_info as *const vk::RenderPassAttachmentBeginInfo).cast::<c_void>()
            } else {
                std::ptr::null()
            },
            render_pass,
            framebuffer,
            render_area,
            clear_value_count: clear_values.len() as u32,
            clear_values: clear_values.as_ptr(),
            ..Default::default()
        };
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
    }

    /// `finishRendering`
    fn finish_rendering(&self, cmd: vk::CommandBuffer) {
        if self.params.use_dynamic_rendering {
            unsafe { self.device.cmd_end_rendering(cmd) };
        } else {
            unsafe { self.device.cmd_end_render_pass(cmd) };
        }
    }

    /// `verifyUsingAtomicChecks`
    fn verify_using_atomic_checks(
        &self,
        tile_width: u32,
        tile_height: u32,
        rate_width: u32,
        rate_height: u32,
        out_buffer: &[u32],
    ) -> bool {
        let mut wrong_fragments = 0u32;
        let fragments_with_same_atomic_value_count = (rate_width * rate_height) as usize;
        // map that uses atomic value as a kay and maps it to all fragments sharing same atomic
        let mut fragments_with_same_atomic_value_map: BTreeMap<u32, Vec<(u32, u32)>> = BTreeMap::new();
        // this method asumes that top and left edge of triangle are parallel to axes and we can store just single coordinate for those edges
        let mut triangle_left_edge_x = 0u32;
        let mut triangle_top_edge_y = 0u32;
        // this method assumes that greatest angle in the triangle points to the top-left corner of FB; these vectors will then store fragments on
        // the right and bottom edges of triangle respectively; for the right edge vector, the index represents y coordinate and value is x; for
        // the bottom edge vector, the index represents x coordinate and value is y
        let mut fragments_on_the_right_triangle_edge_vect = vec![0u32; CB_HEIGHT as usize];
        let mut fragments_on_the_bottom_triangle_edge_vect = vec![0u32; CB_WIDTH as usize];

        // loop over all fragments and validate the output
        for cb_fragment_y in 0..CB_HEIGHT {
            for cb_fragment_x in 0..CB_WIDTH {
                let base = (4 * (cb_fragment_y * CB_WIDTH + cb_fragment_x)) as usize;
                let fragment_color = &out_buffer[base..base + 4];

                // fragment not covered by primitive, skip it
                if fragment_color[2] == 0 {
                    continue;
                }

                // first fragment we hit will define top and left triangle edges
                if triangle_top_edge_y + triangle_left_edge_x == 0 {
                    triangle_left_edge_x = cb_fragment_x;
                    triangle_top_edge_y = cb_fragment_y;
                }

                // constantly overwrite coordinate on right edge so that we are left with the farthest one
                fragments_on_the_right_triangle_edge_vect[cb_fragment_y as usize] = cb_fragment_x;

                // constantly overwrite coordinate on bottom edge so that we are left with the farthest one
                fragments_on_the_bottom_triangle_edge_vect[cb_fragment_x as usize] = cb_fragment_y;

                // make sure that fragment g and a components are 0
                if fragment_color[1] != 0 || fragment_color[3] != 0 {
                    wrong_fragments += 1;
                    continue;
                }

                let rate = fragment_color[0];
                let fragment_rate_x = 1u32 << ((rate / 4) & 3);
                let fragment_rate_y = 1u32 << (rate & 3);

                // check if proper rate was used for fragment
                if fragment_rate_x != rate_width || fragment_rate_y != rate_height {
                    wrong_fragments += 1;
                    continue;
                }

                // find proper set in map and add value to it after doing verification with existing items
                let atomic_value = fragment_color[2];
                match fragments_with_same_atomic_value_map.get_mut(&atomic_value) {
                    None => {
                        let mut fragments = Vec::with_capacity(fragments_with_same_atomic_value_count);
                        fragments.push((cb_fragment_x, cb_fragment_y));
                        fragments_with_same_atomic_value_map.insert(atomic_value, fragments);
                    }
                    Some(fragments_set) => {
                        // make sure that fragments added to set are near the top-left fragment
                        if cb_fragment_x.wrapping_sub(fragments_set[0].0) > rate_width
                            || cb_fragment_y.wrapping_sub(fragments_set[0].1) > rate_height
                        {
                            wrong_fragments += 1;
                        }
                        fragments_set.push((cb_fragment_x, cb_fragment_y));
                    }
                }
            }
        }

        // check if there are no valid fragmenst at all
        if triangle_top_edge_y + triangle_left_edge_x == 0 {
            log::info!("No valid fragments.");
            return false;
        }

        // if checks failed skip checking other tile sizes
        if wrong_fragments != 0 {
            log::info!("Failed {wrong_fragments} fragments for tileWidth: {tile_width}, tileHeight: {tile_height}");
            return false;
        }

        // do additional checks: make sure that there is same number of fragments that share same atomic value
        for fragment_set in fragments_with_same_atomic_value_map.values() {
            if fragment_set.len() != fragments_with_same_atomic_value_count {
                let top_left_fragment = fragment_set[0];
                let triangle_right_edge_x = fragments_on_the_right_triangle_edge_vect[top_left_fragment.1 as usize];
                let triangle_bottom_edge_y = fragments_on_the_bottom_triangle_edge_vect[top_left_fragment.0 as usize];

                // we can only count this as an error if set is fully inside of triangle, sets on edges may not have same number of fragments as
                // sets fully located in the triangle
                if top_left_fragment.1 > triangle_top_edge_y
                    && top_left_fragment.0 > triangle_left_edge_x
                    && top_left_fragment.0 < triangle_right_edge_x.wrapping_sub(rate_width)
                    && top_left_fragment.1 < triangle_bottom_edge_y.wrapping_sub(rate_height)
                {
                    wrong_fragments += fragment_set.len() as u32;
                }
            }
        }

        if wrong_fragments != 0 {
            log::info!(
                "Wrong number of fragments with same atomic value ({wrong_fragments}) for tileWidth: {tile_width}, tileHeight: {tile_height}"
            );
            return false;
        }

        true
    }

    /// The expected rate of a case: 1x1 with a null shading rate image, the case's own rate otherwise.
    fn expected_rate(&self) -> (u32, u32) {
        if self.params.use_null_shading_rate_image {
            (1, 1)
        } else {
            (self.params.sr_rate.width, self.params.sr_rate.height)
        }
    }

    /// The color buffer `index` as the words the fragment shader wrote, once the read back is done.
    fn read_back(&self, index: usize) -> Result<&'static [u32], TestError> {
        let buffer = self.cb_read_buffer[index]
            .as_ref()
            .ok_or_else(|| TestError::InternalError("no read back buffer".to_string()))?;
        invalidate_alloc(self.device, buffer.get_allocation())?;
        Ok(unsafe {
            std::slice::from_raw_parts(
                buffer.get_allocation().get_host_ptr().cast::<u32>().cast_const(),
                (CB_WIDTH * CB_HEIGHT * 4) as usize,
            )
        })
    }

    /// The commands every mode records once the shading rate attachment is ready: the color buffer layout change, the triangle drawn with
    /// the counter buffer bound and the copy of the color buffer to its read back buffer.
    #[allow(clippy::too_many_arguments)]
    fn record_triangle_and_read_back(
        &self,
        cmd: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
        pipeline_layout: vk::PipelineLayout,
        pipeline: vk::Pipeline,
        attachment_info: &[FbAttachment],
        tile: (u32, u32),
    ) {
        let device = self.device;

        // wait till cb image layout is changed
        let cb_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            self.cb_image_handle(0),
            default_range(),
        );
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[],
            &[cb_image_barrier],
        );

        self.start_rendering(
            cmd,
            render_pass,
            framebuffer,
            rect_2d(CB_WIDTH, CB_HEIGHT),
            attachment_info,
            tile,
        );

        // draw single triangle to cb
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                pipeline_layout,
                0,
                &[self.counter_set()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }

        self.finish_rendering(cmd);

        // wait till color attachment is fully written
        let memory_barrier =
            make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            &[memory_barrier],
            &[],
        );

        // read back color buffer image
        if let Some(buffer) = &self.cb_read_buffer[0] {
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    self.cb_image_handle(0),
                    vk::ImageLayout::GENERAL,
                    buffer.get(),
                    &[default_buffer_image_copy()],
                )
            };
        }
    }

    /// The barriers that move the shading rate image `index` from `old_layout` to the shading rate attachment layout (a memory barrier only
    /// when the general layout is used).
    fn shading_rate_ready_barriers(
        &self,
        src_access: vk::AccessFlags,
        old_layout: vk::ImageLayout,
        image_index: usize,
    ) -> (Vec<vk::MemoryBarrier>, Vec<vk::ImageMemoryBarrier>) {
        let memory_barrier =
            make_memory_barrier(src_access, vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR);
        let image_barrier = make_image_memory_barrier(
            src_access,
            vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
            old_layout,
            vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
            self.sr_image_handle(image_index),
            default_range(),
        );
        if self.params.use_general_layout {
            (vec![memory_barrier], vec![])
        } else {
            (vec![memory_barrier], vec![image_barrier])
        }
    }

    /// `runComputeShaderMode`: clear the shading rate attachment, then using a compute shader, set the shading rate attachment values to the
    /// desired rate using various atomic operations, then use it to draw a basic triangle and do basic checks
    fn run_compute_shader_mode(&mut self) -> Result<bool, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let comp_shader = create_shader_module(device, binaries.get("comp")?)?;
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // setup descriptor set with storage image for compute pipeline
        let compute_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let compute_descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let compute_descriptor_set =
            make_descriptor_set(device, *compute_descriptor_pool, *compute_descriptor_set_layout)?;

        self.sr_usage |= vk::ImageUsageFlags::STORAGE;
        self.build_counter_buffer_objects()?;
        self.build_color_buffer_objects(0, self.cb_usage)?;

        // iterate over all possible tile sizes
        for (tile_width, tile_height) in self.tile_sizes() {
            // calculate size of shading rate attachment
            let sr_width = CB_WIDTH.div_ceil(tile_width);
            let sr_height = CB_HEIGHT.div_ceil(tile_height);

            self.build_shading_rate_objects(0, sr_width, sr_height, self.sr_usage, vk::ImageTiling::OPTIMAL)?;

            let compute_descriptor_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: self.sr_view(0),
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(compute_descriptor_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&compute_descriptor_info);
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            let ds_format = self.params.ds_format();
            let compute_pipeline_layout = self.build_pipeline_layout(Some(*compute_descriptor_set_layout))?;
            let graphics_pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
            let compute_pipeline = self.build_compute_pipeline(*comp_shader, *compute_pipeline_layout)?;
            let render_pass = self.build_render_pass(CB_FORMAT, ds_format, (tile_width, tile_height), (0, 0))?;
            let render_pass_handle = render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let graphics_pipeline = self.build_graphics_pipeline(
                0,
                render_pass_handle,
                CB_FORMAT,
                ds_format,
                *graphics_pipeline_layout,
                *vert_shader,
                *frag_shader,
                true,
            )?;

            let attachment_info = [
                FbAttachment {
                    format: CB_FORMAT,
                    usage: self.cb_usage,
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self.cb_view(0),
                },
                FbAttachment {
                    format: self.params.sr_format,
                    usage: self.sr_usage,
                    width: sr_width,
                    height: sr_height,
                    view: self.sr_view(0),
                },
            ];

            // This would need an additional attachment with the depth stencil view and a barrier to transition the DS layout. See
            // `run_fragment_shader_mode` for more details.
            assert!(!self.params.use_depth_stencil());

            let framebuffer = self.build_framebuffer(render_pass_handle, &attachment_info)?;
            let framebuffer_handle = framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            begin_command_buffer(device, cmd)?;

            // wait till sr image layout is changed
            let sr_image_barrier_general = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::empty(),
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                self.sr_image_handle(0),
                default_range(),
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                &[],
                &[sr_image_barrier_general],
            );

            // fill sr image using compute shader
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *compute_pipeline_layout,
                    0,
                    &[compute_descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, sr_width, sr_height, 1);
            }

            // wait till sr image is ready and change sr images layout
            let (memory_barriers, image_barriers) =
                self.shading_rate_ready_barriers(vk::AccessFlags::SHADER_WRITE, vk::ImageLayout::GENERAL, 0);
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                &memory_barriers[..1],
                &image_barriers,
            );

            self.record_triangle_and_read_back(
                cmd,
                render_pass_handle,
                framebuffer_handle,
                *graphics_pipeline_layout,
                *graphics_pipeline,
                &attachment_info,
                (tile_width, tile_height),
            );
            end_command_buffer(device, cmd)?;

            // submit commands and wait
            submit_commands_and_wait(device, self.queue, cmd)?;

            let (rate_width, rate_height) = self.expected_rate();
            if !self.verify_using_atomic_checks(tile_width, tile_height, rate_width, rate_height, self.read_back(0)?) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `runFragmentShaderMode`: set up the image as a color attachment, and render rate to it, then use it to draw a basic triangle and do
    /// basic checks
    fn run_fragment_shader_mode(&mut self) -> Result<bool, TestError> {
        let device = self.device;
        let use_memory_access = self.params.mode == TestMode::MemoryAccess;
        let binaries = self.context.get_binary_collection();
        let vert_setup_shader = create_shader_module(device, binaries.get("vert_setup")?)?;
        let frag_setup_shader = create_shader_module(device, binaries.get("frag_setup")?)?;
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        self.sr_usage |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
        self.build_counter_buffer_objects()?;
        self.build_color_buffer_objects(0, self.cb_usage)?;

        // iterate over all possible tile sizes
        for (tile_width, tile_height) in self.tile_sizes() {
            // calculate size of shading rate attachment
            let sr_width = CB_WIDTH.div_ceil(tile_width);
            let sr_height = CB_HEIGHT.div_ceil(tile_height);

            self.build_shading_rate_objects(0, sr_width, sr_height, self.sr_usage, vk::ImageTiling::OPTIMAL)?;

            let ds_format = self.params.ds_format();
            let setup_pipeline_layout = self.build_pipeline_layout(None)?;
            let rate_pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
            let setup_render_pass =
                self.build_render_pass(self.params.sr_format, vk::Format::UNDEFINED, (0, 0), (0, 0))?;
            let rate_render_pass = self.build_render_pass(CB_FORMAT, ds_format, (tile_width, tile_height), (0, 0))?;
            let setup_render_pass_handle = setup_render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let rate_render_pass_handle = rate_render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let setup_pipeline = self.build_graphics_pipeline(
                0,
                setup_render_pass_handle,
                self.params.sr_format,
                vk::Format::UNDEFINED,
                *setup_pipeline_layout,
                *vert_setup_shader,
                *frag_setup_shader,
                false,
            )?;
            let rate_pipeline = self.build_graphics_pipeline(
                0,
                rate_render_pass_handle,
                CB_FORMAT,
                ds_format,
                *rate_pipeline_layout,
                *vert_shader,
                *frag_shader,
                true,
            )?;

            let setup_attachment_info = [FbAttachment {
                format: self.params.sr_format,
                usage: self.sr_usage,
                width: sr_width,
                height: sr_height,
                view: self.sr_view(0),
            }];
            let mut rate_attachment_info = vec![
                FbAttachment {
                    format: CB_FORMAT,
                    usage: self.cb_usage,
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self.cb_view(0),
                },
                FbAttachment {
                    format: self.params.sr_format,
                    usage: self.sr_usage,
                    width: sr_width,
                    height: sr_height,
                    view: self.sr_view(0),
                },
            ];
            if self.params.use_depth_stencil() {
                rate_attachment_info.push(FbAttachment {
                    format: ds_format,
                    usage: ds_usage(),
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self
                        .ds_image_view
                        .as_ref()
                        .map_or_else(vk::ImageView::null, |view| **view),
                });
            }

            let setup_framebuffer = self.build_framebuffer(setup_render_pass_handle, &setup_attachment_info)?;
            let rate_framebuffer = self.build_framebuffer(rate_render_pass_handle, &rate_attachment_info)?;
            let setup_framebuffer_handle = setup_framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);
            let rate_framebuffer_handle = rate_framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            begin_command_buffer(device, cmd)?;

            // wait till sr image layout is changed
            let sr_image_barrier_general = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                if use_memory_access {
                    vk::AccessFlags::MEMORY_WRITE
                } else {
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                },
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                self.sr_image_handle(0),
                default_range(),
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                &[],
                &[sr_image_barrier_general],
            );

            if self.params.use_depth_stencil() {
                let ds_subresource_range = make_image_subresource_range(get_format_aspect_flags(ds_format), 0, 1, 0, 1);
                let depth_image_read_only_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ,
                    vk::ImageLayout::UNDEFINED,
                    self.params.ds_layout(),
                    self.ds_image.as_ref().map_or_else(vk::Image::null, |image| image.get()),
                    ds_subresource_range,
                );
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    &[],
                    &[depth_image_read_only_barrier],
                );
            }

            // render rate to sr image
            self.start_rendering(
                cmd,
                setup_render_pass_handle,
                setup_framebuffer_handle,
                rect_2d(sr_width, sr_height),
                &setup_attachment_info,
                (0, 0),
            );

            // draw single triangle to cb
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *setup_pipeline);
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }

            self.finish_rendering(cmd);

            // wait till sr image is ready and change sr images layout
            let src_access = if use_memory_access {
                vk::AccessFlags::MEMORY_WRITE
            } else {
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE
            };
            let dst_access = if use_memory_access {
                vk::AccessFlags::MEMORY_READ
            } else {
                vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR
            };
            let memory_barrier_shading_rate = make_memory_barrier(src_access, dst_access);
            let sr_image_barrier_shading_rate = make_image_memory_barrier(
                src_access,
                dst_access,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
                self.sr_image_handle(0),
                default_range(),
            );
            if self.params.use_general_layout {
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[memory_barrier_shading_rate],
                    &[],
                );
            } else {
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[],
                    &[sr_image_barrier_shading_rate],
                );
            }

            // wait till cb image layout is changed
            let cb_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                if use_memory_access {
                    vk::AccessFlags::MEMORY_WRITE
                } else {
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                },
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                self.cb_image_handle(0),
                default_range(),
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                &[],
                &[cb_image_barrier],
            );

            self.start_rendering(
                cmd,
                rate_render_pass_handle,
                rate_framebuffer_handle,
                rect_2d(CB_WIDTH, CB_HEIGHT),
                &rate_attachment_info,
                (tile_width, tile_height),
            );

            // draw single triangle to cb
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *rate_pipeline_layout,
                    0,
                    &[self.counter_set()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *rate_pipeline);
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }

            self.finish_rendering(cmd);

            // wait till color attachment is fully written
            let memory_barrier = make_memory_barrier(
                if use_memory_access {
                    vk::AccessFlags::MEMORY_WRITE
                } else {
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                },
                if use_memory_access {
                    vk::AccessFlags::MEMORY_READ
                } else {
                    vk::AccessFlags::TRANSFER_READ
                },
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                &[memory_barrier],
                &[],
            );

            // read back color buffer image
            if let Some(buffer) = &self.cb_read_buffer[0] {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        self.cb_image_handle(0),
                        vk::ImageLayout::GENERAL,
                        buffer.get(),
                        &[default_buffer_image_copy()],
                    )
                };
            }
            end_command_buffer(device, cmd)?;

            // submit commands and wait
            submit_commands_and_wait(device, self.queue, cmd)?;

            let (rate_width, rate_height) = self.expected_rate();
            if !self.verify_using_atomic_checks(tile_width, tile_height, rate_width, rate_height, self.read_back(0)?) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `runCopyMode`: clear a separate image of the same format to that rate, copy it to the shading rate image, then use it to draw a basic
    /// triangle and do basic checks
    fn run_copy_mode(&mut self) -> Result<bool, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        self.build_counter_buffer_objects()?;
        self.build_color_buffer_objects(0, self.cb_usage)?;

        // iterate over all possible tile sizes
        for (tile_width, tile_height) in self.tile_sizes() {
            // calculate size of shading rate attachment
            let sr_width = CB_WIDTH.div_ceil(tile_width);
            let sr_height = CB_HEIGHT.div_ceil(tile_height);

            self.build_shading_rate_objects(0, sr_width, sr_height, self.sr_usage, vk::ImageTiling::OPTIMAL)?;

            // create image that will be source for shading rate image
            let sr_src_image = self.build_image_with_memory(
                self.params.sr_format,
                sr_width,
                sr_height,
                vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageTiling::OPTIMAL,
                &[],
            )?;

            let ds_format = self.params.ds_format();
            let graphics_pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
            let render_pass = self.build_render_pass(CB_FORMAT, ds_format, (tile_width, tile_height), (0, 0))?;
            let render_pass_handle = render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let graphics_pipeline = self.build_graphics_pipeline(
                0,
                render_pass_handle,
                CB_FORMAT,
                ds_format,
                *graphics_pipeline_layout,
                *vert_shader,
                *frag_shader,
                true,
            )?;

            let attachment_info = [
                FbAttachment {
                    format: CB_FORMAT,
                    usage: self.cb_usage,
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self.cb_view(0),
                },
                FbAttachment {
                    format: self.params.sr_format,
                    usage: self.sr_usage,
                    width: sr_width,
                    height: sr_height,
                    view: self.sr_view(0),
                },
            ];

            assert!(!self.params.use_depth_stencil());

            let framebuffer = self.build_framebuffer(render_pass_handle, &attachment_info)?;
            let framebuffer_handle = framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            begin_command_buffer(device, cmd)?;

            // wait till sr images layout are changed
            let mut sr_image_barrier_general = [make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE | vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                self.sr_image_handle(0),
                default_range(),
            ); 2];
            sr_image_barrier_general[1].image = sr_src_image.get();
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &[],
                &sr_image_barrier_general,
            );

            // clear source sr image with proper rate
            let clear_value = vk::ClearColorValue {
                uint32: [
                    calculate_rate(self.params.sr_rate.width, self.params.sr_rate.height),
                    0,
                    0,
                    0,
                ],
            };
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    sr_src_image.get(),
                    vk::ImageLayout::GENERAL,
                    &clear_value,
                    &[default_range()],
                )
            };

            // wait till sr source image is ready
            let memory_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                &[memory_barrier],
                &[],
            );

            // copy sr source image to sr image used during rendering
            let image_copy_region = vk::ImageCopy {
                src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: vk::Extent3D {
                    width: sr_width,
                    height: sr_height,
                    depth: 1,
                },
            };
            unsafe {
                device.cmd_copy_image(
                    cmd,
                    sr_src_image.get(),
                    vk::ImageLayout::GENERAL,
                    self.sr_image_handle(0),
                    vk::ImageLayout::GENERAL,
                    &[image_copy_region],
                )
            };

            // wait till sr image is ready and change sr images layout
            let (memory_barriers, image_barriers) =
                self.shading_rate_ready_barriers(vk::AccessFlags::TRANSFER_WRITE, vk::ImageLayout::GENERAL, 0);
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                &memory_barriers,
                &image_barriers,
            );

            self.record_triangle_and_read_back(
                cmd,
                render_pass_handle,
                framebuffer_handle,
                *graphics_pipeline_layout,
                *graphics_pipeline,
                &attachment_info,
                (tile_width, tile_height),
            );
            end_command_buffer(device, cmd)?;

            // submit commands and wait
            submit_commands_and_wait(device, self.queue, cmd)?;

            let (rate_width, rate_height) = self.expected_rate();
            if !self.verify_using_atomic_checks(tile_width, tile_height, rate_width, rate_height, self.read_back(0)?) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `runCopyModeOnTransferQueue`: clear a separate image of the same format to that rate, copy it to the shading rate image on separate
    /// transfer queue and then use copied image to draw a basic triangle and do basic checks
    fn run_copy_mode_on_transfer_queue(
        &mut self,
        families: &[crate::vkt::context::QueueFamilyQueues],
    ) -> Result<bool, TestError> {
        let device = self.device;
        let mut transfer_queue_family_index = u32::MAX;
        let mut graphics_queue_family_index = u32::MAX;

        // find graphics and transfer queue families
        for family in families {
            let queue_flags = family.flags;
            if graphics_queue_family_index == u32::MAX && queue_flags.contains(vk::QueueFlags::GRAPHICS) {
                graphics_queue_family_index = family.family_index;
            } else if family.family_index != graphics_queue_family_index
                && queue_flags.contains(vk::QueueFlags::TRANSFER)
            {
                transfer_queue_family_index = family.family_index;
            }
        }

        if transfer_queue_family_index == u32::MAX {
            return Err(TestError::NotSupported("No separate transfer queue".to_string()));
        }
        if graphics_queue_family_index == u32::MAX {
            return Err(TestError::NotSupported("No separate graphics queue".to_string()));
        }

        // using queueFamilies vector to determine if sr image uses exclusiv or concurrent sharing
        let concurrent = self.params.mode == TestMode::SetupRateWithCopyingFromConcurrentImageUsingTransferQueue;
        let queue_families: Vec<u32> = if concurrent {
            vec![graphics_queue_family_index, transfer_queue_family_index]
        } else {
            Vec::new()
        };

        let queue_of = |family_index: u32| {
            families
                .iter()
                .find(|family| family.family_index == family_index)
                .and_then(|family| family.queues.first().copied())
                .ok_or_else(|| TestError::InternalError("no queue in the family".to_string()))
        };
        let transfer_queue = queue_of(transfer_queue_family_index)?;
        let graphics_queue = queue_of(graphics_queue_family_index)?;
        self.queue_family_index = graphics_queue_family_index;

        // create transfer and graphics command buffers
        let transfer_cmd_pool = make_command_pool(device, transfer_queue_family_index)?;
        let transfer_cmd_buffer = allocate_command_buffer(device, *transfer_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let graphics_cmd_pool = make_command_pool(device, graphics_queue_family_index)?;
        let graphics_cmd_buffer = allocate_command_buffer(device, *graphics_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = self.context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        self.build_color_buffer_objects(0, self.cb_usage)?;
        self.build_counter_buffer_objects()?;

        // iterate over all possible tile sizes
        for (tile_width, tile_height) in self.tile_sizes() {
            // calculate size of shading rate attachment
            let sr_width = CB_WIDTH.div_ceil(tile_width);
            let sr_height = CB_HEIGHT.div_ceil(tile_height);

            // create image that will be source for shading rate image
            let sr_src_image = self.build_image_with_memory(
                self.params.sr_format,
                sr_width,
                sr_height,
                vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageTiling::OPTIMAL,
                &[],
            )?;

            // create buffer that will contain shading rate source data
            let sr_write_buffer_size = sr_width * sr_height * sr_fill_pixel_size(self.params.sr_format);
            let sr_src_buffer =
                self.build_buffer_with_memory(sr_write_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC)?;

            // fill buffer with tested shading rate
            let value = calculate_rate(self.params.sr_rate.width, self.params.sr_rate.height) as u8;
            unsafe {
                std::ptr::write_bytes(
                    sr_src_buffer.get_allocation().get_host_ptr(),
                    value,
                    sr_write_buffer_size as usize,
                )
            };
            flush_alloc(device, sr_src_buffer.get_allocation())?;

            // create shading rate iamge
            let sr_image = self.build_image_with_memory(
                self.params.sr_format,
                sr_width,
                sr_height,
                vk::ImageUsageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR | vk::ImageUsageFlags::TRANSFER_DST,
                vk::ImageTiling::OPTIMAL,
                &queue_families,
            )?;
            self.sr_image_view[0] = Some(self.build_image_view(self.params.sr_format, sr_image.get())?);
            self.sr_image[0] = Some(sr_image);

            let ds_format = self.params.ds_format();
            let graphics_pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
            let render_pass = self.build_render_pass(CB_FORMAT, ds_format, (tile_width, tile_height), (0, 0))?;
            let render_pass_handle = render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let graphics_pipeline = self.build_graphics_pipeline(
                0,
                render_pass_handle,
                CB_FORMAT,
                ds_format,
                *graphics_pipeline_layout,
                *vert_shader,
                *frag_shader,
                true,
            )?;

            let attachment_info = [
                FbAttachment {
                    format: CB_FORMAT,
                    usage: self.cb_usage,
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self.cb_view(0),
                },
                FbAttachment {
                    format: self.params.sr_format,
                    usage: self.sr_usage,
                    width: sr_width,
                    height: sr_height,
                    view: self.sr_view(0),
                },
            ];

            assert!(!self.params.use_depth_stencil());

            let framebuffer = self.build_framebuffer(render_pass_handle, &attachment_info)?;
            let framebuffer_handle = framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            let transfer_cmd = *transfer_cmd_buffer;
            begin_command_buffer(device, transfer_cmd)?;

            // wait till sr data is ready in buffer and change sr image layouts to general
            let mut sr_image_barrier_general = [make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                self.sr_image_handle(0),
                default_range(),
            ); 2];
            sr_image_barrier_general[1].image = sr_src_image.get();
            pipeline_barrier(
                device,
                transfer_cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                &[],
                &sr_image_barrier_general,
            );

            // copy sr data to images
            let sr_copy_buffer = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: sr_width,
                    height: sr_height,
                    depth: 1,
                },
            };
            unsafe {
                device.cmd_copy_buffer_to_image(
                    transfer_cmd,
                    sr_src_buffer.get(),
                    sr_src_image.get(),
                    vk::ImageLayout::GENERAL,
                    &[sr_copy_buffer],
                )
            };

            // wait till sr source image is ready
            let memory_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
            pipeline_barrier(
                device,
                transfer_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                &[memory_barrier],
                &[],
            );

            // copy sr source image to sr image used during rendering
            let image_copy_region = vk::ImageCopy {
                src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: vk::Extent3D {
                    width: sr_width,
                    height: sr_height,
                    depth: 1,
                },
            };
            unsafe {
                device.cmd_copy_image(
                    transfer_cmd,
                    sr_src_image.get(),
                    vk::ImageLayout::GENERAL,
                    self.sr_image_handle(0),
                    vk::ImageLayout::GENERAL,
                    &[image_copy_region],
                )
            };

            // release exclusive ownership from the transfer queue family
            let mut sr_image_barrier_ownership_transfer = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::empty(),
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                self.sr_image_handle(0),
                default_range(),
            );
            if self.params.mode == TestMode::SetupRateWithCopyingFromExclusiveImageUsingTransferQueue {
                sr_image_barrier_ownership_transfer.src_queue_family_index = transfer_queue_family_index;
                sr_image_barrier_ownership_transfer.dst_queue_family_index = graphics_queue_family_index;
            }
            pipeline_barrier(
                device,
                transfer_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                &[],
                &[sr_image_barrier_ownership_transfer],
            );
            end_command_buffer(device, transfer_cmd)?;

            let graphics_cmd = *graphics_cmd_buffer;
            begin_command_buffer(device, graphics_cmd)?;

            // acquire exclusive ownership for the graphics queue family - while changing sr images layout
            pipeline_barrier(
                device,
                graphics_cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                &[],
                &[sr_image_barrier_ownership_transfer],
            );

            // wait till sr image layout is changed
            let sr_memory_barrier_shading_rate = make_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
            );
            let sr_image_barrier_shading_rate = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
                self.sr_image_handle(0),
                default_range(),
            );
            if self.params.use_general_layout {
                pipeline_barrier(
                    device,
                    graphics_cmd,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[sr_memory_barrier_shading_rate],
                    &[],
                );
            } else {
                pipeline_barrier(
                    device,
                    graphics_cmd,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[],
                    &[sr_image_barrier_shading_rate],
                );
            }

            self.record_triangle_and_read_back(
                graphics_cmd,
                render_pass_handle,
                framebuffer_handle,
                *graphics_pipeline_layout,
                *graphics_pipeline,
                &attachment_info,
                (tile_width, tile_height),
            );
            end_command_buffer(device, graphics_cmd)?;

            // create synchronization objects
            let semaphore = Unique::new(
                device,
                unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                    .vk_check("vkCreateSemaphore")?,
            );
            let transfer_fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let graphics_fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );

            let transfer_command_buffers = [transfer_cmd];
            let transfer_signal_semaphores = [*semaphore];
            let transfer_submit_info = vk::SubmitInfo::builder()
                .command_buffers(&transfer_command_buffers)
                .signal_semaphores(&transfer_signal_semaphores);
            let wait_dst_stage_mask = [vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR];
            let graphics_command_buffers = [graphics_cmd];
            let graphics_wait_semaphores = [*semaphore];
            let graphics_submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&graphics_wait_semaphores)
                .wait_dst_stage_mask(&wait_dst_stage_mask)
                .command_buffers(&graphics_command_buffers);

            // submit commands to both queues
            unsafe { device.queue_submit(transfer_queue, &[transfer_submit_info], *transfer_fence) }
                .vk_check("vkQueueSubmit")?;
            unsafe { device.queue_submit(graphics_queue, &[graphics_submit_info], *graphics_fence) }
                .vk_check("vkQueueSubmit")?;
            unsafe { device.wait_for_fences(&[*graphics_fence, *transfer_fence], true, u64::MAX) }
                .vk_check("vkWaitForFences")?;

            let (rate_width, rate_height) = self.expected_rate();
            if !self.verify_using_atomic_checks(tile_width, tile_height, rate_width, rate_height, self.read_back(0)?) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `runFillLinearTiledImage`: create a linear tiled fragment shading rate attachment image and set its data on the host, then draw a
    /// basic triangle and do basic checks
    fn run_fill_linear_tiled_image(&mut self) -> Result<bool, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        self.build_counter_buffer_objects()?;
        self.build_color_buffer_objects(0, self.cb_usage)?;

        // iterate over all possible tile sizes
        for (tile_width, tile_height) in self.tile_sizes() {
            // calculate size of shading rate attachment
            let sr_width = CB_WIDTH.div_ceil(tile_width);
            let sr_height = CB_HEIGHT.div_ceil(tile_height);

            self.build_shading_rate_objects(0, sr_width, sr_height, self.sr_usage, vk::ImageTiling::LINEAR)?;

            let image_ptr = self.sr_image[0]
                .as_ref()
                .map(|image| image.get_allocation().get_host_ptr())
                .ok_or_else(|| TestError::InternalError("no shading rate image".to_string()))?;
            let value = calculate_rate(self.params.sr_rate.width, self.params.sr_rate.height) as u8;

            // fill sr image on the host row by row
            let image_subresource = vk::ImageSubresource {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                array_layer: 0,
            };
            let sr_image_layout =
                unsafe { device.get_image_subresource_layout(self.sr_image_handle(0), &image_subresource) };
            for sr_texel_row in 0..sr_height {
                let row_offset =
                    sr_image_layout.offset + sr_image_layout.row_pitch * vk::DeviceSize::from(sr_texel_row);
                unsafe { std::ptr::write_bytes(image_ptr.add(row_offset as usize), value, sr_width as usize) };
            }
            if let Some(image) = &self.sr_image[0] {
                flush_alloc(device, image.get_allocation())?;
            }

            let ds_format = self.params.ds_format();
            let graphics_pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
            let render_pass = self.build_render_pass(CB_FORMAT, ds_format, (tile_width, tile_height), (0, 0))?;
            let render_pass_handle = render_pass
                .as_ref()
                .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
            let graphics_pipeline = self.build_graphics_pipeline(
                0,
                render_pass_handle,
                CB_FORMAT,
                ds_format,
                *graphics_pipeline_layout,
                *vert_shader,
                *frag_shader,
                true,
            )?;

            let attachment_info = [
                FbAttachment {
                    format: CB_FORMAT,
                    usage: self.cb_usage,
                    width: CB_WIDTH,
                    height: CB_HEIGHT,
                    view: self.cb_view(0),
                },
                FbAttachment {
                    format: self.params.sr_format,
                    usage: self.sr_usage,
                    width: sr_width,
                    height: sr_height,
                    view: self.sr_view(0),
                },
            ];

            assert!(!self.params.use_depth_stencil());

            let framebuffer = self.build_framebuffer(render_pass_handle, &attachment_info)?;
            let framebuffer_handle = framebuffer
                .as_ref()
                .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

            begin_command_buffer(device, cmd)?;

            // wait till sr image layout is changed
            let sr_memory_barrier_attachment = make_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
            );
            let sr_image_barrier_attachment = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
                self.sr_image_handle(0),
                default_range(),
            );
            if self.params.use_general_layout {
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[sr_memory_barrier_attachment],
                    &[],
                );
            } else {
                pipeline_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
                    &[],
                    &[sr_image_barrier_attachment],
                );
            }

            self.record_triangle_and_read_back(
                cmd,
                render_pass_handle,
                framebuffer_handle,
                *graphics_pipeline_layout,
                *graphics_pipeline,
                &attachment_info,
                (tile_width, tile_height),
            );
            end_command_buffer(device, cmd)?;

            // submit commands and wait
            submit_commands_and_wait(device, self.queue, cmd)?;

            let (rate_width, rate_height) = self.expected_rate();
            if !self.verify_using_atomic_checks(tile_width, tile_height, rate_width, rate_height, self.read_back(0)?) {
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `runTwoSubpassMode`: set up a two-subpass render pass with different shading rate attachments used in each subpass. Then draw a basic
    /// triangle in each subpass and do basic checks.
    fn run_two_subpass_mode(&mut self) -> Result<bool, TestError> {
        let device = self.device;
        let binaries = self.context.get_binary_collection();
        let vert_shader0 = create_shader_module(device, binaries.get("vert0")?)?;
        let vert_shader1 = create_shader_module(device, binaries.get("vert1")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let cmd_pool = make_command_pool(device, self.queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // fetch information about supported rates
        let supported_fragment_shading_rates = supported_fragment_shading_rates(self.context);
        let supported_count = supported_fragment_shading_rates.len();
        if supported_count < 2 {
            return Err(TestError::InternalError(
                "too few supported fragment shading rates".to_string(),
            ));
        }

        // grab min and max tile sieze and biggest and smallest rate
        let sr0_width = CB_WIDTH.div_ceil(self.min_tile_size.width);
        let sr0_height = CB_HEIGHT.div_ceil(self.min_tile_size.height);
        let sr1_width = CB_WIDTH.div_ceil(self.max_tile_size.width);
        let sr1_height = CB_HEIGHT.div_ceil(self.max_tile_size.height);
        // bigets supported rate
        let sr0_rate = supported_fragment_shading_rates[0].fragment_size;
        // smallest supported rate excluding {1, 1}
        let sr1_rate = supported_fragment_shading_rates[supported_count - 2].fragment_size;

        self.build_color_buffer_objects(0, self.cb_usage)?;
        self.build_color_buffer_objects(1, self.cb_usage)?;
        self.build_shading_rate_objects(0, sr0_width, sr0_height, self.sr_usage, vk::ImageTiling::OPTIMAL)?;
        self.build_shading_rate_objects(1, sr1_width, sr1_height, self.sr_usage, vk::ImageTiling::OPTIMAL)?;
        self.build_counter_buffer_objects()?;

        let ds_format = self.params.ds_format();
        let render_pass = self.build_render_pass(
            CB_FORMAT,
            ds_format,
            (self.min_tile_size.width, self.min_tile_size.height),
            (self.max_tile_size.width, self.max_tile_size.height),
        )?;
        let render_pass_handle = render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |render_pass| **render_pass);
        let pipeline_layout = self.build_pipeline_layout(Some(self.counter_layout()))?;
        let graphics_pipeline0 = self.build_graphics_pipeline(
            0,
            render_pass_handle,
            CB_FORMAT,
            ds_format,
            *pipeline_layout,
            *vert_shader0,
            *frag_shader,
            true,
        )?;
        let graphics_pipeline1 = self.build_graphics_pipeline(
            1,
            render_pass_handle,
            CB_FORMAT,
            ds_format,
            *pipeline_layout,
            *vert_shader1,
            *frag_shader,
            true,
        )?;

        let attachment_info = [
            FbAttachment {
                format: CB_FORMAT,
                usage: self.cb_usage,
                width: CB_WIDTH,
                height: CB_HEIGHT,
                view: self.cb_view(0),
            },
            FbAttachment {
                format: self.params.sr_format,
                usage: self.sr_usage,
                width: sr0_width,
                height: sr0_height,
                view: self.sr_view(0),
            },
            FbAttachment {
                format: CB_FORMAT,
                usage: self.cb_usage,
                width: CB_WIDTH,
                height: CB_HEIGHT,
                view: self.cb_view(1),
            },
            FbAttachment {
                format: self.params.sr_format,
                usage: self.sr_usage,
                width: sr1_width,
                height: sr1_height,
                view: self.sr_view(1),
            },
        ];

        assert!(!self.params.use_depth_stencil());

        let framebuffer = self.build_framebuffer(render_pass_handle, &attachment_info)?;
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        begin_command_buffer(device, cmd)?;

        // change sr image layouts to general
        let mut sr_image_barrier_general = [make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            self.sr_image_handle(0),
            default_range(),
        ); 2];
        sr_image_barrier_general[1].image = self.sr_image_handle(1);
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[],
            &sr_image_barrier_general,
        );

        let clear_values = [
            vk::ClearColorValue {
                uint32: [calculate_rate(sr0_rate.width, sr0_rate.height), 0, 0, 0],
            },
            vk::ClearColorValue {
                uint32: [calculate_rate(sr1_rate.width, sr1_rate.height), 0, 0, 0],
            },
        ];
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                self.sr_image_handle(0),
                vk::ImageLayout::GENERAL,
                &clear_values[0],
                &[default_range()],
            );
            device.cmd_clear_color_image(
                cmd,
                self.sr_image_handle(1),
                vk::ImageLayout::GENERAL,
                &clear_values[1],
                &[default_range()],
            );
        }

        // wait till sr data is ready and change sr images layout
        let memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
        );
        let mut sr_image_barrier_shading_rate = [make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR,
            self.sr_image_handle(0),
            default_range(),
        ); 2];
        sr_image_barrier_shading_rate[1].image = self.sr_image_handle(1);
        let image_barriers: &[vk::ImageMemoryBarrier] = if self.params.use_general_layout {
            &[]
        } else {
            &sr_image_barrier_shading_rate
        };
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::FRAGMENT_SHADING_RATE_ATTACHMENT_KHR,
            &[memory_barrier],
            image_barriers,
        );

        // wait till cb image layouts are changed
        let mut cb_image_barrier = [make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            self.cb_image_handle(0),
            default_range(),
        ); 2];
        cb_image_barrier[1].image = self.cb_image_handle(1);
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[],
            &cb_image_barrier,
        );

        self.start_rendering(
            cmd,
            render_pass_handle,
            framebuffer_handle,
            rect_2d(CB_WIDTH, CB_HEIGHT),
            &attachment_info,
            (0, 0),
        );

        // draw single triangle to first cb
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[self.counter_set()],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline0);
            device.cmd_draw(cmd, 3, 1, 0, 0);
            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
        }

        // draw single triangle to second cb
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline1);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }

        self.finish_rendering(cmd);

        // wait till color attachments are fully written
        let memory_barrier =
            make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
        pipeline_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            &[memory_barrier],
            &[],
        );

        // read back color buffer images
        for index in 0..2 {
            if let Some(buffer) = &self.cb_read_buffer[index] {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        self.cb_image_handle(index),
                        vk::ImageLayout::GENERAL,
                        buffer.get(),
                        &[default_buffer_image_copy()],
                    )
                };
            }
        }
        end_command_buffer(device, cmd)?;

        // submit commands and wait
        submit_commands_and_wait(device, self.queue, cmd)?;

        // validate both attachemtns triangle
        Ok(self.verify_using_atomic_checks(
            self.min_tile_size.width,
            self.min_tile_size.height,
            sr0_rate.width,
            sr0_rate.height,
            self.read_back(0)?,
        ) && self.verify_using_atomic_checks(
            self.max_tile_size.width,
            self.max_tile_size.height,
            sr1_rate.width,
            sr1_rate.height,
            self.read_back(1)?,
        ))
    }
}

/// `createAttachmentRateTests`
pub fn create_attachment_rate_tests(parent_group: &mut TestCaseGroup, group_params: GroupParams) {
    let sr_formats = [
        (vk::Format::R8_UINT, "r8_uint"),
        (vk::Format::R8G8_UINT, "r8g8_uint"),
        (vk::Format::R8G8B8_UINT, "r8g8b8_uint"),
        (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
        (vk::Format::R16_UINT, "r16_uint"),
        (vk::Format::R16G16_UINT, "r16g16_uint"),
        (vk::Format::R16G16B16_UINT, "r16g16b16_uint"),
        (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
        (vk::Format::R32_UINT, "r32_uint"),
        (vk::Format::R32G32_UINT, "r32g32_uint"),
        (vk::Format::R32G32B32_UINT, "r32g32b32_uint"),
        (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
        (vk::Format::R64_UINT, "r64_uint"),
        (vk::Format::R64G64_UINT, "r64g64_uint"),
        (vk::Format::R64G64B64_UINT, "r64g64b64_uint"),
        (vk::Format::R64G64B64A64_UINT, "r64g64b64a64_uint"),
    ];

    let sr_rates = [
        (vk::Extent2D { width: 1, height: 1 }, "rate_1x1"),
        (vk::Extent2D { width: 1, height: 2 }, "rate_1x2"),
        (vk::Extent2D { width: 1, height: 4 }, "rate_1x4"),
        (vk::Extent2D { width: 2, height: 1 }, "rate_2x1"),
        (vk::Extent2D { width: 2, height: 2 }, "rate_2x2"),
        (vk::Extent2D { width: 2, height: 4 }, "rate_2x4"),
        (vk::Extent2D { width: 4, height: 1 }, "rate_4x1"),
        (vk::Extent2D { width: 4, height: 2 }, "rate_4x2"),
        (vk::Extent2D { width: 4, height: 4 }, "rate_4x4"),
    ];

    let test_mode_params = [
        (TestMode::SetupRateWithAtomicsInComputeShader, "setup_with_atomics"),
        (TestMode::SetupRateWithFragmentShader, "setup_with_fragment"),
        (TestMode::SetupRateWithCopyingFromOtherImage, "setup_with_copying"),
        (
            TestMode::SetupRateWithCopyingFromConcurrentImageUsingTransferQueue,
            "setup_with_copying_using_transfer_queue_concurent",
        ),
        (
            TestMode::SetupRateWithCopyingFromExclusiveImageUsingTransferQueue,
            "setup_with_copying_using_transfer_queue_exclusive",
        ),
        (TestMode::SetupRateWithLinearTiledImage, "setup_with_linear_tiled_image"),
    ];

    let base_params = |mode: TestMode, sr_format: vk::Format, sr_rate: vk::Extent2D| TestParams {
        mode,
        sr_format,
        sr_rate,
        use_dynamic_rendering: group_params.use_dynamic_rendering,
        use_imageless_framebuffer: false,
        use_null_shading_rate_image: false,
        use_general_layout: false,
        ds_params: None,
    };
    let case = |name: &str, params: TestParams| {
        Box::new(AttachmentRateCase {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>
    };

    let mut main_group = TestCaseGroup::new("attachment_rate");

    for (mode, mode_name) in test_mode_params {
        let mut test_mode_group = TestCaseGroup::new(mode_name);

        for (sr_format, format_name) in sr_formats {
            let mut format_group = TestCaseGroup::new(format_name);
            for (sr_rate, rate_name) in sr_rates {
                format_group.add_child(case(rate_name, base_params(mode, sr_format, sr_rate)));

                if group_params.use_dynamic_rendering {
                    // Duplicate all tests using dynamic rendering for NULL shading image.
                    format_group.add_child(case(
                        &format!("{rate_name}_null_shading"),
                        TestParams {
                            use_null_shading_rate_image: true,
                            ..base_params(mode, sr_format, sr_rate)
                        },
                    ));
                } else {
                    // duplicate all tests for imageless framebuffer
                    format_group.add_child(case(
                        &format!("{rate_name}_imageless"),
                        TestParams {
                            use_imageless_framebuffer: true,
                            ..base_params(mode, sr_format, sr_rate)
                        },
                    ));

                    // duplicate all tests using only general layout
                    format_group.add_child(case(
                        &format!("{rate_name}_general_layout"),
                        TestParams {
                            use_general_layout: true,
                            ..base_params(mode, sr_format, sr_rate)
                        },
                    ));
                }
            }

            test_mode_group.add_child(format_group);
        }

        main_group.add_child(test_mode_group);
    }

    let mut misc_group = TestCaseGroup::new("misc");
    if !group_params.use_dynamic_rendering {
        misc_group.add_child(case(
            "two_subpass",
            base_params(
                TestMode::TwoSubpass,
                vk::Format::R8_UINT,
                vk::Extent2D { width: 0, height: 0 },
            ),
        ));
        misc_group.add_child(case(
            "memory_access",
            base_params(
                TestMode::MemoryAccess,
                vk::Format::R8_UINT,
                vk::Extent2D { width: 1, height: 1 },
            ),
        ));

        let tested_layouts = [
            (vk::ImageLayout::READ_ONLY_OPTIMAL, "read_only_optimal"),
            (vk::ImageLayout::DEPTH_READ_ONLY_OPTIMAL, "depth_read_only_optimal"),
            (vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL, "stencil_read_only_optimal"),
            (vk::ImageLayout::GENERAL, "general"),
        ];
        for (layout, layout_name) in tested_layouts {
            let ds_format = if layout == vk::ImageLayout::STENCIL_READ_ONLY_OPTIMAL {
                vk::Format::S8_UINT
            } else {
                vk::Format::D16_UNORM
            };
            let params = TestParams {
                ds_params: Some(DepthStencilParams {
                    format: ds_format,
                    layout,
                }),
                ..base_params(
                    TestMode::MemoryAccess,
                    vk::Format::R8_UINT,
                    vk::Extent2D { width: 2, height: 2 },
                )
            };
            misc_group.add_child(case(&format!("ro_ds_{layout_name}"), params));
        }
    } else {
        misc_group.add_child(case(
            "maintenance5",
            base_params(
                TestMode::Maintenance5,
                vk::Format::R8_UINT,
                vk::Extent2D { width: 1, height: 1 },
            ),
        ));
    }
    main_group.add_child(misc_group);

    parent_group.add_child(main_group);
}
