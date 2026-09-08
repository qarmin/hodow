// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiBufferViewAccessTests.cpp
//   (BufferViewAllFormatsTestCase / BufferViewAllFormatsTestInstance)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A compute shader reads four fixed texels out of a texel buffer view and writes them
// to an SSBO; the host compares them against the same texels decoded from its own copy
// of the buffer. The point is the *view*: the same bytes are read back through every
// format Vulkan allows a texel buffer to be created with.
//
// The graphics half of this file (BufferViewTestInstance, which renders through the
// view) is not ported - it needs a graphics pipeline.

use vulkanalia::prelude::v1_0::*;

use super::copy_format_lists::BUFFER_VIEW_ACCESS_FORMATS;
use crate::tcu::pixel::{PixelBufferAccess, TextureLevel};
use crate::tcu::texture::TextureChannelClass;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, get_shader_image_format_qualifier, is_supported_image_load_store, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info, make_descriptor_set, make_framebuffer,
    make_graphics_pipeline, make_pipeline_layout, make_render_pass,
};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// One shader variant, as `api_buffer_view_access.toml` declares it.
///
/// The GLSL tokens are carried here as well as substituted into the shader so the host
/// can pick its program by matching `fmt_layout` against the qualifier it computes for
/// the format it is about to bind. Choosing by index instead would let a manifest edit
/// silently pair a format with the wrong shader.
pub struct BufferViewAccessProgram {
    pub name: &'static str,
    pub storage_type: &'static str,
    pub extra_option: &'static str,
    pub fmt_layout: &'static str,
    pub op_name: &'static str,
    pub in_format: &'static str,
    pub out_format: &'static str,
    pub programs: BinaryCollection,
}

/// `bufferSize` / `bufferViewSize` / the four sample points.
const BUFFER_SIZE: u32 = 512;
/// `SAMPLE_POINT_0..3`
const FETCH_POSITIONS: [u32; 4] = [6, 51, 42, 25];
/// `m_sourceView` is 64 texels wide whatever the format's texel size is.
const SOURCE_VIEW_WIDTH: u32 = 64;

/// Which of the two ways the view is bound. Upstream expresses it as a usage flag
/// pair; the only thing the test does differently is the descriptor type, the format
/// feature it requires, and which shader it runs.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BindKind {
    Uniform,
    Storage,
}

/// `BufferViewAllFormatsTestCase`
pub struct BufferViewAllFormatsCase {
    name: String,
    format: vk::Format,
    /// `createUsage` - what the buffer is created with. The uniform_storage group
    /// creates it with both and then binds it as one of them.
    create_usage: vk::BufferUsageFlags,
    /// `bindUsage` - `None` is upstream's VK_BUFFER_USAGE_FLAG_BITS_MAX_ENUM sentinel,
    /// meaning the view is bound the way the buffer was created.
    bind_usage: Option<vk::BufferUsageFlags>,
    bind_kind: BindKind,
}

/// `vk::isScaledFormat` for the channel types a texel buffer can have.
fn is_scaled_type(format: tcu::TextureFormat) -> bool {
    use crate::tcu::texture::ChannelType::*;
    matches!(
        format.type_,
        USCALED_INT8 | USCALED_INT16 | SSCALED_INT8 | SSCALED_INT16 | USCALED_INT_1010102_REV | SSCALED_INT_1010102_REV
    )
}

/// The manifest entry this case's shader must come from.
///
/// The scalar prefix follows the channel class, and the storage variants additionally
/// have to name the format's layout qualifier. `None` means no ported shader describes
/// this format, which for a registered case is a port bug rather than a driver verdict.
fn select_program(format: vk::Format, bind_kind: BindKind) -> Option<&'static BufferViewAccessProgram> {
    use crate::generated::shaders::api_buffer_view_access as sh;

    let tcu_format = map_vk_format(format)?;
    let out_format = match tcu_format.channel_class() {
        TextureChannelClass::SignedInteger => "i",
        TextureChannelClass::UnsignedInteger => "u",
        _ => "",
    };
    // `inFormat` drops the prefix for a scaled format: the texel is stored as an
    // integer but sampled as a float, so the sampler type has no prefix while the
    // result still does.
    let in_format = if is_scaled_type(tcu_format) { "" } else { out_format };

    let all: &[&'static BufferViewAccessProgram] = &[
        &sh::BV_UNIFORM_FLOAT,
        &sh::BV_UNIFORM_INT,
        &sh::BV_UNIFORM_UINT,
        &sh::BV_UNIFORM_SSCALED,
        &sh::BV_UNIFORM_USCALED,
        &sh::BV_STORAGE_RGB10_A2,
        &sh::BV_STORAGE_RGB10_A2UI,
        &sh::BV_STORAGE_RGBA16,
        &sh::BV_STORAGE_RGBA16_SNORM,
        &sh::BV_STORAGE_RGBA16F,
        &sh::BV_STORAGE_RGBA16I,
        &sh::BV_STORAGE_RGBA16UI,
        &sh::BV_STORAGE_RGBA8,
        &sh::BV_STORAGE_RGBA8_SNORM,
        &sh::BV_STORAGE_RGBA8I,
        &sh::BV_STORAGE_RGBA8UI,
    ];

    let want_layout = match bind_kind {
        BindKind::Uniform => String::new(),
        BindKind::Storage => format!(", {}", get_shader_image_format_qualifier(tcu_format, format)?),
    };

    all.iter()
        .copied()
        .find(|p| p.fmt_layout == want_layout && p.in_format == in_format && p.out_format == out_format)
}

impl TestCase for BufferViewAllFormatsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if matches!(self.format, vk::Format::A8_UNORM | vk::Format::A1B5G5R5_UNORM_PACK16) {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        let props = unsafe { context.get_instance().get_physical_device_format_properties(context.get_physical_device(), self.format) };
        if self.create_usage.contains(vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER) && !props.buffer_features.contains(vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER) {
            return Err(TestError::NotSupported("VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT not supported for format".to_string()));
        }

        // `checkTexelBufferSupport`, which the instance runs before it builds anything.
        let feature = match self.bind_kind {
            BindKind::Uniform => vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER,
            BindKind::Storage => vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER,
        };
        if !props.buffer_features.contains(feature) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        if self.bind_usage.is_some() && !context.is_device_functionality_supported("VK_KHR_maintenance5") && !context.is_device_functionality_supported("VK_KHR_extended_flags") {
            return Err(TestError::NotSupported(
                "Extensions VK_KHR_maintenance5 and VK_KHR_extended_flags not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        select_program(self.format, self.bind_kind).map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferViewAllFormatsInstance { context, params: self })
    }
}

struct BufferViewAllFormatsInstance<'a> {
    context: &'a Context<'a>,
    params: &'a BufferViewAllFormatsCase,
}

/// `populateSourceBuffer` - taken from BindingShaderAccessTests.cpp
///
/// A gradient, a three-level pattern and a triangle wave, so an offset error of any
/// size shows up somewhere. Alpha gets red^green rather than a constant, because
/// A8_UNORM reads nothing else.
fn populate_source_buffer(access: &mut PixelBufferAccess<'_>) -> Result<(), TestError> {
    let width = access.size()[0] as i32;
    for x in 0..width {
        let red = 255 * x / width;
        let green = if x % 2 == 0 { 127 } else { 0 } + if x % 4 < 3 { 128 } else { 0 };
        let blue = 16 * (x % 16);
        if !access.set_pixel_int([red, green, blue, red ^ green], x as u32, 0, 0) {
            return Err(TestError::NotPorted(format!("integer write path for {:?}", access.format())));
        }
    }
    Ok(())
}

impl TestInstance for BufferViewAllFormatsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let program = select_program(p.format, p.bind_kind).ok_or_else(|| TestError::NotPorted(format!("no shader variant for {:?}", p.format)))?;
        let tcu_format = map_vk_format(p.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let pixel_size = tcu_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))?;

        // The host copy of the buffer, and the 64-texel view the reference reads from.
        let mut source_level = TextureLevel::new(tcu_format, BUFFER_SIZE / pixel_size, 1, 1)?;
        populate_source_buffer(&mut source_level.get_access())?;
        let source_bytes = source_level.data().to_vec();

        let result_size = (4 * 4 * 4) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let texel_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(source_bytes.len() as vk::DeviceSize, p.create_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(source_bytes.as_ptr(), texel_buffer.get_allocation().get_host_ptr(), source_bytes.len()) };
        flush_alloc(device, texel_buffer.get_allocation())?;

        // `VkBufferUsageFlags2CreateInfoKHR` chains onto the view when the group binds
        // the buffer as something other than what it was created with.
        let mut usage2 = vk::BufferUsageFlags2CreateInfo {
            s_type: vk::StructureType::BUFFER_USAGE_FLAGS_2_CREATE_INFO,
            next: std::ptr::null(),
            usage: vk::BufferUsageFlags2::empty(),
        };
        let mut view_info = vk::BufferViewCreateInfo {
            s_type: vk::StructureType::BUFFER_VIEW_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::BufferViewCreateFlags::empty(),
            buffer: texel_buffer.get(),
            format: p.format,
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        if let Some(bind_usage) = p.bind_usage {
            usage2.usage = vk::BufferUsageFlags2::from_bits_truncate(u64::from(bind_usage.bits()));
            view_info.next = std::ptr::addr_of!(usage2).cast();
        }
        let buffer_view = Unique::new(device, unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?);

        let descriptor_type = match p.bind_kind {
            BindKind::Uniform => vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            BindKind::Storage => vk::DescriptorType::STORAGE_TEXEL_BUFFER,
        };
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(descriptor_type, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let result_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &result_info)
            .update(device);
        // The texel-buffer write carries a view rather than a buffer info, so it does
        // not go through the update builder.
        unsafe {
            let view = *buffer_view;
            let write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set,
                dst_binding: 1,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type,
                image_info: std::ptr::null(),
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::addr_of!(view),
            };
            device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]);
        }

        let mut pipeline = ComputePipelineWrapper::new(device, ComputePipelineConstructionType::Pipeline, program.programs.get("comp")?);
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            pipeline.bind(*cmd_buffer);
            device.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
            device.cmd_dispatch(*cmd_buffer, 4, 1, 1);
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let mut results = [[0u32; 4]; 4];
        unsafe { std::ptr::copy_nonoverlapping(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<[u32; 4]>(), results.as_mut_ptr(), 4) };

        // `m_sourceView` - the same bytes, viewed 64 texels wide.
        let source_view = crate::tcu::pixel::ConstPixelBufferAccess::new(tcu_format, [SOURCE_VIEW_WIDTH, 1, 1], &source_bytes);
        let is_int = matches!(tcu_format.channel_class(), TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger);

        for (ndx, pos) in FETCH_POSITIONS.iter().enumerate() {
            if is_int {
                let reference = source_view.get_pixel_int(*pos, 0, 0).map(|v| v as u32);
                if results[ndx] != reference {
                    return Ok(TestStatus::fail("Invalid result values"));
                }
            } else {
                let reference = source_view.get_pixel(*pos, 0, 0);
                let result: [f32; 4] = std::array::from_fn(|c| f32::from_bits(results[ndx][c]));
                // `conversionThreshold` - one 8-bit step, which is what the source
                // pattern is built out of.
                if (0..4).any(|c| (result[c] - reference[c]).abs() > 1.0 / 255.0) {
                    return Ok(TestStatus::fail("Invalid result values"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createBufferViewAccessTests`' all-formats half.
pub fn add_buffer_view_all_formats_tests(parent: &mut TestCaseGroup) {
    let uniform = vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER;
    let storage = vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER;

    for (group_name, create_usage, bind_usage, bind_kind) in [
        ("uniform_texel_buffer", uniform, None, BindKind::Uniform),
        ("storage_texel_buffer", storage, None, BindKind::Storage),
    ] {
        let mut group = TestCaseGroup::new(group_name);
        add_formats(&mut group, create_usage, bind_usage, bind_kind);
        parent.add_child(group);
    }

    let mut uniform_storage = TestCaseGroup::new("uniform_storage_texel_buffer");
    for (group_name, bind_usage, bind_kind) in [("bind_as_uniform", uniform, BindKind::Uniform), ("bind_as_storage", storage, BindKind::Storage)] {
        let mut group = TestCaseGroup::new(group_name);
        add_formats(&mut group, uniform | storage, Some(bind_usage), bind_kind);
        uniform_storage.add_child(group);
    }
    parent.add_child(uniform_storage);
}

fn add_formats(group: &mut TestCaseGroup, create_usage: vk::BufferUsageFlags, bind_usage: Option<vk::BufferUsageFlags>, bind_kind: BindKind) {
    for (format, name) in BUFFER_VIEW_ACCESS_FORMATS {
        let Some(tcu_format) = map_vk_format(*format) else { continue };
        // A storage texel buffer can only be declared for a format that has an image
        // layout qualifier, which is the same set `isSupportedImageLoadStore` names.
        if bind_kind == BindKind::Storage && !is_supported_image_load_store(tcu_format, *format) {
            continue;
        }
        group.add_child(Box::new(BufferViewAllFormatsCase {
            name: (*name).to_string(),
            format: *format,
            create_usage,
            bind_usage,
            bind_kind,
        }) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// BufferViewTestCase / BufferViewTestInstance - the memory tests.
// ---------------------------------------------------------------------------------

/// `BufferViewCaseParams` for the memory tests.
pub struct BufferViewMemoryCase {
    name: String,
    /// How many uint32 values the buffer holds.
    buffer_size: u32,
    /// How many of them the view covers, and the side of the rendered square.
    buffer_view_size: u32,
    /// Where the view starts, in elements.
    element_offset: u32,
    /// `useComputePipeline` - the same read done by a dispatch instead of a draw.
    use_compute_pipeline: bool,
    buffer_dedicated: bool,
    image_dedicated: bool,
}

impl TestCase for BufferViewMemoryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.buffer_dedicated || self.image_dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        use crate::generated::shaders::api_buffer_view_access as sh;
        if self.use_compute_pipeline {
            sh::BV_MEMORY_COMPUTE.programs
        } else {
            sh::BV_MEMORY_GRAPHICS.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferViewMemoryInstance { context, params: self })
    }
}

struct BufferViewMemoryInstance<'a> {
    context: &'a Context<'a>,
    params: &'a BufferViewMemoryCase,
}

/// `generateBuffer` - the view reads back `factor * i`, so a wrong offset shows up as a
/// wrong multiple rather than as noise.
fn generate_uniform_data(buffer_size: u32, factor: u32) -> Vec<u32> {
    (0..buffer_size).map(|i| factor.wrapping_mul(i)).collect()
}

impl BufferViewMemoryInstance<'_> {
    /// `MultiQueueRunnerTestInstance` - the queues the case runs on, one pass each.
    fn queues(&self) -> Vec<(vk::Queue, u32)> {
        let mut out = vec![(self.context.get_universal_queue(), self.context.get_universal_queue_family_index())];
        if self.params.use_compute_pipeline
            && let Some(q) = self.context.get_compute_queue()
        {
            out.push(q);
        }
        out
    }
}

impl TestInstance for BufferViewMemoryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        const COLOR_FORMAT: vk::Format = vk::Format::R32_UINT;
        let render_size = p.buffer_view_size;
        let pixel_data_size = u64::from(render_size) * u64::from(render_size) * 4;

        // Colour attachment (or storage image, in the compute path) and its view.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: COLOR_FORMAT,
            extent: vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: if p.use_compute_pipeline {
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
            } else {
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
            },
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let color_image = if p.image_dedicated {
            ImageWithMemory::new_dedicated(device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?
        };
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // The texel buffer and its view.
        let uniform_size = u64::from(p.buffer_size) * 4;
        let uniform_buffer = if p.buffer_dedicated {
            BufferWithMemory::new_dedicated(
                device,
                allocator,
                make_buffer_create_info(uniform_size, vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?
        } else {
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(uniform_size, vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?
        };
        let view_info = vk::BufferViewCreateInfo {
            s_type: vk::StructureType::BUFFER_VIEW_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::BufferViewCreateFlags::empty(),
            buffer: uniform_buffer.get(),
            format: COLOR_FORMAT,
            offset: u64::from(p.element_offset) * 4,
            range: vk::WHOLE_SIZE,
        };
        let buffer_view = Unique::new(device, unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?);

        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(pixel_data_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut layout_builder = DescriptorSetLayoutBuilder::new().add_single_binding(vk::DescriptorType::UNIFORM_TEXEL_BUFFER, vk::ShaderStageFlags::ALL);
        let mut pool_builder = DescriptorPoolBuilder::new().add_type(vk::DescriptorType::UNIFORM_TEXEL_BUFFER, 1);
        if p.use_compute_pipeline {
            layout_builder = layout_builder.add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::ALL);
            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_IMAGE, 1);
        }
        let set_layout = layout_builder.build(device)?;
        let descriptor_pool = pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        unsafe {
            let view = *buffer_view;
            let mut writes = vec![vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: *descriptor_set,
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::addr_of!(view),
            }];
            let image_info = vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *color_view,
                image_layout: vk::ImageLayout::GENERAL,
            };
            if p.use_compute_pipeline {
                writes.push(vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: *descriptor_set,
                    dst_binding: 1,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                    image_info: std::ptr::addr_of!(image_info),
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                });
            }
            device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]);
        }

        let programs = self.params.programs();
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        // The graphics path needs a render pass, a framebuffer, a quad and a pipeline;
        // the compute path needs only the pipeline.
        let graphics = if p.use_compute_pipeline {
            None
        } else {
            let render_pass = make_render_pass(device, COLOR_FORMAT)?;
            let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], render_size, render_size, 1)?;
            let vert = create_shader_module(device, programs.get("vert")?)?;
            let frag = create_shader_module(device, programs.get("frag")?)?;
            let pipeline = make_graphics_pipeline(
                device,
                *pipeline_layout,
                *vert,
                *frag,
                *render_pass,
                (render_size, render_size),
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?;
            // `createQuad` - two triangles covering the whole target.
            let a = [-1.0f32, -1.0, 0.0, 1.0];
            let b = [1.0f32, -1.0, 0.0, 1.0];
            let c = [1.0f32, 1.0, 0.0, 1.0];
            let d = [-1.0f32, 1.0, 0.0, 1.0];
            let vertices = [a, c, b, c, a, d];
            let vertex_data_size = std::mem::size_of_val(&vertices) as u64;
            let vertex_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(vertex_data_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(vertices.as_ptr().cast::<u8>(), vertex_buffer.get_allocation().get_host_ptr(), vertex_data_size as usize);
            }
            flush_alloc(device, vertex_buffer.get_allocation())?;
            Some((render_pass, framebuffer, vert, frag, pipeline, vertex_buffer, vertices.len() as u32))
        };

        let compute = if p.use_compute_pipeline {
            let comp = create_shader_module(device, programs.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*comp)
                .name(c"main".to_bytes_with_nul());
            let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(*pipeline_layout);
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }.vk_check("vkCreateComputePipelines")?;
            Some((comp, Unique::new(device, pipelines.0[0])))
        } else {
            None
        };

        for (queue, family_index) in self.queues() {
            let cmd_pool = make_command_pool(device, family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            self.record(
                *cmd_buffer,
                &graphics,
                &compute,
                *pipeline_layout,
                *descriptor_set,
                color_image.get(),
                result_buffer.get(),
                render_size,
            )?;

            // `queuePass` runs the same command buffer twice, refilling the buffer in
            // between, so the second pass proves the view still reads live memory.
            for factor in [1u32, 2] {
                let data = generate_uniform_data(p.buffer_size, factor);
                unsafe {
                    std::ptr::copy_nonoverlapping(data.as_ptr().cast::<u8>(), uniform_buffer.get_allocation().get_host_ptr(), std::mem::size_of_val(&data[..]));
                }
                flush_alloc(device, uniform_buffer.get_allocation())?;
                submit_commands_and_wait(device, queue, *cmd_buffer)?;

                invalidate_alloc(device, result_buffer.get_allocation())?;
                let mut pixels = vec![0u32; (render_size * render_size) as usize];
                unsafe {
                    std::ptr::copy_nonoverlapping(result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(), pixels.as_mut_ptr(), pixels.len());
                }
                // `checkResult` - the diagonal, which is where both paths write.
                for i in 0..render_size {
                    let actual = pixels[(i * render_size + i) as usize];
                    let expected = factor.wrapping_mul(p.element_offset + i);
                    if actual != expected {
                        return Ok(TestStatus::fail("BufferView test failed"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("BufferView test"))
    }
}

type GraphicsParts<'a> = (
    Unique<'a, vk::RenderPass>,
    Unique<'a, vk::Framebuffer>,
    Unique<'a, vk::ShaderModule>,
    Unique<'a, vk::ShaderModule>,
    Unique<'a, vk::Pipeline>,
    BufferWithMemory<'a>,
    u32,
);

impl BufferViewMemoryInstance<'_> {
    /// `recordCommandBuffer`
    #[allow(clippy::too_many_arguments)]
    fn record(
        &self,
        cmd_buffer: vk::CommandBuffer,
        graphics: &Option<GraphicsParts<'_>>,
        compute: &Option<(Unique<'_, vk::ShaderModule>, Unique<'_, vk::Pipeline>)>,
        pipeline_layout: vk::PipelineLayout,
        descriptor_set: vk::DescriptorSet,
        color_image: vk::Image,
        result_buffer: vk::Buffer,
        render_size: u32,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: 1,
            },
        };

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            if let Some((render_pass, framebuffer, _, _, pipeline, vertex_buffer, vertex_count)) = graphics {
                let initial = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image,
                    range,
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[initial],
                );

                let clear = vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0, 0, 0, 0] },
                };
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(**render_pass)
                    .framebuffer(**framebuffer)
                    .render_area(vk::Rect2D {
                        offset: vk::Offset2D { x: 0, y: 0 },
                        extent: vk::Extent2D {
                            width: render_size,
                            height: render_size,
                        },
                    })
                    .clear_values(std::slice::from_ref(&clear));
                device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                device.cmd_bind_descriptor_sets(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_layout, 0, &[descriptor_set], &[]);
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd_buffer, *vertex_count, 1, 0, 0);
                device.cmd_end_render_pass(cmd_buffer);

                let to_src = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_image,
                    range,
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_src],
                );
                device.cmd_copy_image_to_buffer(cmd_buffer, color_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, result_buffer, &[copy_region]);
            } else if let Some((_, pipeline)) = compute {
                let initial = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    color_image,
                    range,
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[initial],
                );

                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, **pipeline);
                device.cmd_bind_descriptor_sets(cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline_layout, 0, &[descriptor_set], &[]);

                let clear = vk::ClearColorValue { uint32: [0, 0, 0, 0] };
                device.cmd_clear_color_image(cmd_buffer, color_image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &clear, &[range]);

                let to_general = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    color_image,
                    range,
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_general],
                );

                device.cmd_dispatch(cmd_buffer, render_size, 1, 1);

                let to_src = make_image_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_image,
                    range,
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_src],
                );
                device.cmd_copy_image_to_buffer(cmd_buffer, color_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, result_buffer, &[copy_region]);
            }
        }
        end_command_buffer(device, cmd_buffer)
    }
}

/// `createBufferViewAccessTests`' memory-test half.
pub fn add_buffer_view_memory_tests(parent: &mut TestCaseGroup) {
    let buffer_texts = ["buffer_suballocated", "buffer_dedicated_alloc"];
    let image_texts = ["image_suballocated", "image_dedicated_alloc"];
    let queue_texts = ["graphics", "compute"];

    let mut suballocation = TestCaseGroup::new("suballocation");
    let mut dedicated = TestCaseGroup::new("dedicated_alloc");

    for buffer_dedicated in [false, true] {
        for image_dedicated in [false, true] {
            for use_compute in [false, true] {
                let is_suballocated = !buffer_dedicated && !image_dedicated;
                let group = if is_suballocated { &mut suballocation } else { &mut dedicated };
                let suffix = if is_suballocated {
                    String::new()
                } else {
                    format!("_with_{}_{}", buffer_texts[usize::from(buffer_dedicated)], image_texts[usize::from(image_dedicated)])
                };
                let queue = queue_texts[usize::from(use_compute)];

                for (stem, buffer_size, buffer_view_size, element_offset) in [
                    ("buffer_view_memory_test_complete", 512, 512, 0),
                    ("buffer_view_memory_test_partial_offset0", 4096, 512, 0),
                    ("buffer_view_memory_test_partial_offset1", 4096, 512, 128),
                ] {
                    group.add_child(Box::new(BufferViewMemoryCase {
                        name: format!("{stem}{suffix}_{queue}"),
                        buffer_size,
                        buffer_view_size,
                        element_offset,
                        use_compute_pipeline: use_compute,
                        buffer_dedicated,
                        image_dedicated,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }

    parent.add_child(suballocation);
    parent.add_child(dedicated);
}
