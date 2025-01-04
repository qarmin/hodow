// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The cases and the verification shaders come from scripts/gen_descriptor_copy_manifest.py (which
// rebuilds every case the way `addDescriptorCopyTests` and its siblings do) as `descriptor_copy_table.rs`; this file is `DescriptorCommands::run`
// and the descriptor classes' `init`/`getDescriptorWrite` over that table, plus `CopyImmutableSamplerTest`.

use std::collections::BTreeMap;
use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::descriptor_copy_table::{
    CASES, CaseDef, DescriptorDef, IMMUTABLE_SAMPLER_CASES, ImmutableSamplerDef, Kind, Pipeline,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_graphics_pipeline_staged,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 64;

fn descriptor_type(kind: Kind) -> vk::DescriptorType {
    match kind {
        Kind::Ubo => vk::DescriptorType::UNIFORM_BUFFER,
        Kind::DynUbo => vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC,
        Kind::Ssbo => vk::DescriptorType::STORAGE_BUFFER,
        Kind::DynSsbo => vk::DescriptorType::STORAGE_BUFFER_DYNAMIC,
        Kind::Utb => vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
        Kind::Stb => vk::DescriptorType::STORAGE_TEXEL_BUFFER,
        Kind::Iub => vk::DescriptorType::INLINE_UNIFORM_BLOCK,
        Kind::Input => vk::DescriptorType::INPUT_ATTACHMENT,
        Kind::Combined => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
        Kind::Sampled => vk::DescriptorType::SAMPLED_IMAGE,
        Kind::Sampler => vk::DescriptorType::SAMPLER,
        Kind::StorageImage => vk::DescriptorType::STORAGE_IMAGE,
    }
}

fn is_buffer(kind: Kind) -> bool {
    matches!(
        kind,
        Kind::Ubo | Kind::DynUbo | Kind::Ssbo | Kind::DynSsbo | Kind::Utb | Kind::Stb
    )
}

fn is_dynamic(kind: Kind) -> bool {
    matches!(kind, Kind::DynUbo | Kind::DynSsbo)
}

fn uses_buffer_view(kind: Kind) -> bool {
    matches!(kind, Kind::Utb | Kind::Stb)
}

fn is_image(kind: Kind) -> bool {
    matches!(kind, Kind::Input | Kind::Combined | Kind::Sampled | Kind::StorageImage)
}

fn buffer_usage(kind: Kind) -> vk::BufferUsageFlags {
    match kind {
        Kind::Ubo | Kind::DynUbo => vk::BufferUsageFlags::UNIFORM_BUFFER,
        Kind::Ssbo | Kind::DynSsbo => vk::BufferUsageFlags::STORAGE_BUFFER,
        Kind::Utb => vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
        _ => vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
    }
}

fn image_usage(kind: Kind) -> vk::ImageUsageFlags {
    match kind {
        Kind::Input => vk::ImageUsageFlags::INPUT_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST,
        Kind::StorageImage => {
            vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST
        }
        _ => vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
    }
}

fn image_layout(kind: Kind) -> vk::ImageLayout {
    if kind == Kind::StorageImage {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    }
}

fn image_access(kind: Kind) -> vk::AccessFlags {
    if kind == Kind::Input {
        vk::AccessFlags::INPUT_ATTACHMENT_READ
    } else {
        vk::AccessFlags::SHADER_READ
    }
}

/// `Descriptor::getFirstWrittenElement` and `getNumWrittenElements`
fn first_written_element(def: &DescriptorDef) -> u32 {
    if def.elements_to_write > 0 { def.write_start } else { 0 }
}

/// The `Descriptor`'s resources, `init`ed.
enum Backing<'a> {
    Buffer {
        buffer: BufferWithMemory<'a>,
        infos: Vec<vk::DescriptorBufferInfo>,
        #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
        views: Vec<Unique<'a, vk::BufferView>>,
        view_handles: Vec<vk::BufferView>,
    },
    /// `PaddedUint`: the value and 12 bytes of padding, which is how std140 lays out an int array.
    Inline {
        #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
        data: Vec<[u32; 4]>,
        write: Box<vk::WriteDescriptorSetInlineUniformBlock>,
    },
    Image {
        #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
        sampler: Unique<'a, vk::Sampler>,
        #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
        images: Vec<ImageWithMemory<'a>>,
        views: Vec<Unique<'a, vk::ImageView>>,
        infos: Vec<vk::DescriptorImageInfo>,
    },
    Sampler {
        #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
        samplers: Vec<Unique<'a, vk::Sampler>>,
        infos: Vec<vk::DescriptorImageInfo>,
    },
}

struct DescriptorResources<'a> {
    def: &'static DescriptorDef,
    backing: Backing<'a>,
}

/// `mapSampler` for the nearest filtered, normalized coordinate samplers these descriptors use.
fn make_sampler<'a>(
    context: &'a Context<'_>,
    address_mode: vk::SamplerAddressMode,
    border_color: vk::BorderColor,
) -> Result<Unique<'a, vk::Sampler>, TestError> {
    let device = context.get_device();
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(address_mode)
        .address_mode_v(address_mode)
        .address_mode_w(address_mode)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.25)
        .border_color(border_color)
        .unnormalized_coordinates(false);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

impl<'a> DescriptorResources<'a> {
    /// `Descriptor::init`
    fn new(context: &'a Context<'a>, def: &'static DescriptorDef, pipeline: Pipeline) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let kind = def.kind;

        let backing = if is_buffer(kind) {
            let buffer_size = (256 * def.array_size * def.areas) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size, buffer_usage(kind)),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            let infos: Vec<vk::DescriptorBufferInfo> = (0..def.array_size)
                .map(|array_idx| vk::DescriptorBufferInfo {
                    buffer: buffer.get(),
                    offset: (256 * def.areas * array_idx) as vk::DeviceSize,
                    range: if is_dynamic(kind) { 256 } else { 4 },
                })
                .collect();

            let mut views = Vec::new();
            let mut view_handles = Vec::new();
            if uses_buffer_view(kind) {
                for view_idx in 0..def.array_size {
                    let info = vk::BufferViewCreateInfo::builder()
                        .buffer(buffer.get())
                        .format(vk::Format::R32_SFLOAT)
                        .offset((256 * view_idx) as vk::DeviceSize)
                        .range(4);
                    let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;
                    view_handles.push(view);
                    views.push(Unique::new(device, view));
                }
            }

            // Initialize buffer memory
            {
                let host_ptr = buffer.get_allocation().get_host_ptr() as *mut u32;
                for array_idx in 0..def.array_size {
                    for area_idx in 0..def.areas {
                        let value = def.id + array_idx * def.areas + area_idx;
                        let word = if uses_buffer_view(kind) {
                            (value as f32).to_bits()
                        } else {
                            value
                        };
                        unsafe {
                            host_ptr
                                .add(((256 / 4) * (def.areas * array_idx + area_idx)) as usize)
                                .write(word)
                        };
                    }
                }
                flush_alloc(device, buffer.get_allocation())?;
            }

            Backing::Buffer {
                buffer,
                infos,
                views,
                view_handles,
            }
        } else if kind == Kind::Iub {
            let data: Vec<[u32; 4]> = (0..def.array_size).map(|i| [def.id + i, 0, 0, 0]).collect();
            let write = Box::new(vk::WriteDescriptorSetInlineUniformBlock {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET_INLINE_UNIFORM_BLOCK,
                next: std::ptr::null(),
                data_size: def.elements_to_write * 16,
                data: data.as_ptr().wrapping_add(def.write_start as usize).cast::<c_void>(),
            });
            Backing::Inline { data, write }
        } else if is_image(kind) {
            let sampler = make_sampler(
                context,
                vk::SamplerAddressMode::CLAMP_TO_EDGE,
                vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            )?;
            let format = vk::Format::R32_SFLOAT;
            let queue_family_index = context.get_universal_queue_family_index();
            let queue_family_indices = [queue_family_index];

            let mut images = Vec::new();
            let mut views = Vec::new();
            for _ in 0..def.array_size {
                let info = vk::ImageCreateInfo::builder()
                    .image_type(vk::ImageType::_2D)
                    .format(format)
                    .extent(vk::Extent3D {
                        width: RENDER_SIZE,
                        height: RENDER_SIZE,
                        depth: 1,
                    })
                    .mip_levels(1)
                    .array_layers(1)
                    .samples(vk::SampleCountFlags::_1)
                    .tiling(vk::ImageTiling::OPTIMAL)
                    .usage(image_usage(kind))
                    .sharing_mode(vk::SharingMode::EXCLUSIVE)
                    .queue_family_indices(&queue_family_indices)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .build();
                let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
                views.push(make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    format,
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                )?);
                images.push(image);
            }

            let infos: Vec<vk::DescriptorImageInfo> = views
                .iter()
                .map(|view| vk::DescriptorImageInfo {
                    sampler: *sampler,
                    image_view: **view,
                    image_layout: image_layout(kind),
                })
                .collect();

            // Clear images to reference value
            let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            for (image_idx, image) in images.iter().enumerate() {
                let cmd_pool = make_command_pool(device, queue_family_index)?;
                let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                let cmd = *cmd_buffer;

                let clear_value = (def.id + image_idx as u32) as f32;
                let clear_color = vk::ClearColorValue {
                    float32: [clear_value; 4],
                };
                let pre_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image.get(),
                    range,
                );
                let post_barrier = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    image_access(kind),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image_layout(kind),
                    image.get(),
                    range,
                );

                begin_command_buffer(device, cmd)?;
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_barrier],
                    );
                    device.cmd_clear_color_image(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_color,
                        &[range],
                    );
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        if pipeline == Pipeline::Compute {
                            vk::PipelineStageFlags::COMPUTE_SHADER
                        } else {
                            vk::PipelineStageFlags::FRAGMENT_SHADER
                        },
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[post_barrier],
                    );
                }
                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
            }

            Backing::Image {
                sampler,
                images,
                views,
                infos,
            }
        } else {
            // Kind::Sampler: the border colour alternates so that a copy of the wrong sampler shows.
            let mut samplers = Vec::new();
            for i in 0..def.array_size {
                let border_color = if (def.id + i) % 2 == 1 {
                    vk::BorderColor::FLOAT_OPAQUE_WHITE
                } else {
                    vk::BorderColor::FLOAT_TRANSPARENT_BLACK
                };
                samplers.push(make_sampler(
                    context,
                    vk::SamplerAddressMode::CLAMP_TO_BORDER,
                    border_color,
                )?);
            }
            let infos = samplers
                .iter()
                .map(|sampler| vk::DescriptorImageInfo {
                    sampler: **sampler,
                    image_view: vk::ImageView::null(),
                    image_layout: vk::ImageLayout::UNDEFINED,
                })
                .collect();
            Backing::Sampler { samplers, infos }
        };

        Ok(Self { def, backing })
    }

    /// `Descriptor::getDescriptorWrite`; set and binding are filled in by the caller.
    fn descriptor_write(&self) -> vk::WriteDescriptorSet {
        let def = self.def;
        let first = first_written_element(def) as usize;
        let mut write = vk::WriteDescriptorSet {
            dst_array_element: first as u32,
            descriptor_count: def.elements_to_write,
            descriptor_type: descriptor_type(def.kind),
            ..Default::default()
        };
        match &self.backing {
            Backing::Buffer {
                infos, view_handles, ..
            } => {
                if uses_buffer_view(def.kind) {
                    write.texel_buffer_view = view_handles[first..].as_ptr();
                } else {
                    write.buffer_info = infos[first..].as_ptr();
                }
            }
            Backing::Inline {
                write: inline_write, ..
            } => {
                write.next = (&**inline_write as *const vk::WriteDescriptorSetInlineUniformBlock).cast();
                write.dst_array_element = def.write_start * 16;
                write.descriptor_count = def.elements_to_write * 16;
            }
            Backing::Image { infos, .. } | Backing::Sampler { infos, .. } => write.image_info = infos[first..].as_ptr(),
        }
        write
    }

    /// Image views of an input attachment descriptor, which go to the framebuffer.
    fn attachment_views(&self) -> Vec<vk::ImageView> {
        match (&self.backing, self.def.kind) {
            (Backing::Image { views, .. }, Kind::Input) => views.iter().map(|view| **view).collect(),
            _ => Vec::new(),
        }
    }
}

/// `DescriptorCopyTestCase`
struct DescriptorCopyCase {
    def: &'static CaseDef,
}

impl TestCase for DescriptorCopyCase {
    fn name(&self) -> &str {
        self.def.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support(context, self.def)
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DescriptorCopyInstance { context, def: self.def })
    }
}

/// `DescriptorCommands::checkSupport`
fn check_support(context: &Context<'_>, def: &CaseDef) -> Result<(), TestError> {
    let limits = context.get_device_properties().limits;
    let not_supported = |message: &str| Err(TestError::NotSupported(message.to_string()));

    if limits.max_bound_descriptor_sets as usize <= def.set_count {
        return not_supported("Maximum bound descriptor sets limit exceeded.");
    }

    if def.update_after_bind {
        context.require_device_functionality("VK_EXT_descriptor_indexing")?;
    }

    let mut iub_properties = vk::PhysicalDeviceInlineUniformBlockProperties::default();
    if context.is_device_functionality_supported("VK_EXT_inline_uniform_block") {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut iub_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }

    let mut num_total_iubs = 0u32;
    let (
        mut per_stage_samplers,
        mut per_stage_ubos,
        mut per_stage_ssbos,
        mut per_stage_sampled,
        mut per_stage_storage,
        mut per_stage_input,
        mut per_stage_total,
    ) = (0u32, 0u32, 0u32, 0u32, 0u32, 0u32, 0u32);
    let (mut uses_ubo, mut uses_sampled, mut uses_storage_image, mut uses_ssbo, mut uses_utb, mut uses_stb) =
        (false, false, false, false, false, false);

    for set_idx in 0..def.set_count {
        let (
            mut samplers,
            mut ubos,
            mut ubos_dynamic,
            mut ssbos,
            mut ssbos_dynamic,
            mut sampled,
            mut storage,
            mut input,
        ) = (0u32, 0u32, 0u32, 0u32, 0u32, 0u32, 0u32, 0u32);
        let mut total = if def.pipeline == Pipeline::Graphics { 1u32 } else { 0 }; // Color buffer counts as a resource.

        for (binding_idx, descriptor) in def.descriptors.iter().filter(|d| d.set as usize == set_idx).enumerate() {
            let array_size = descriptor.array_size;
            if descriptor.kind == Kind::Iub {
                if descriptor.array_size * 16 > iub_properties.max_inline_uniform_block_size {
                    return Err(TestError::NotSupported(format!(
                        "Maximum size for an inline uniform block exceeded by binding {binding_idx} from set {set_idx}"
                    )));
                }
                total += 1;
            } else {
                total += array_size;
            }

            match descriptor.kind {
                Kind::Ubo => {
                    ubos += array_size;
                    uses_ubo = true;
                }
                Kind::DynUbo => {
                    ubos += array_size;
                    ubos_dynamic += array_size;
                }
                Kind::Ssbo => {
                    ssbos += array_size;
                    uses_ssbo = true;
                }
                Kind::DynSsbo => {
                    ssbos += array_size;
                    ssbos_dynamic += array_size;
                }
                Kind::Combined => {
                    samplers += array_size;
                    sampled += array_size;
                    uses_sampled = true;
                }
                Kind::StorageImage => {
                    storage += array_size;
                    uses_storage_image = true;
                }
                Kind::Stb => {
                    storage += array_size;
                    uses_stb = true;
                }
                Kind::Input => input += array_size,
                Kind::Sampled => {
                    sampled += array_size;
                    uses_sampled = true;
                }
                Kind::Utb => {
                    sampled += array_size;
                    uses_utb = true;
                }
                Kind::Sampler => {
                    samplers += array_size;
                    uses_sampled = true;
                }
                Kind::Iub => num_total_iubs += 1,
            }
        }

        if samplers > limits.max_descriptor_set_samplers {
            return not_supported("Maximum per descriptor set sampler limit exceeded.");
        }
        if ubos > limits.max_descriptor_set_uniform_buffers {
            return not_supported("Maximum per descriptor set uniform buffer limit exceeded.");
        }
        if ubos_dynamic > limits.max_descriptor_set_uniform_buffers_dynamic {
            return not_supported("Maximum per descriptor set uniform buffer dynamic limit exceeded.");
        }
        if ssbos > limits.max_descriptor_set_storage_buffers {
            return not_supported("Maximum per descriptor set storage buffer limit exceeded.");
        }
        if ssbos_dynamic > limits.max_descriptor_set_storage_buffers_dynamic {
            return not_supported("Maximum per descriptor set storage buffer dynamic limit exceeded.");
        }
        if sampled > limits.max_descriptor_set_sampled_images {
            return not_supported("Maximum per descriptor set sampled image limit exceeded.");
        }
        if storage > limits.max_descriptor_set_storage_images {
            return not_supported("Maximum per descriptor set storage image limit exceeded.");
        }
        if input > limits.max_descriptor_set_input_attachments {
            return not_supported("Maximum per descriptor set input attachment limit exceeded.");
        }

        per_stage_samplers += samplers;
        per_stage_ubos += ubos;
        per_stage_ssbos += ssbos;
        per_stage_sampled += sampled;
        per_stage_storage += storage;
        per_stage_input += input;
        per_stage_total += total;
    }

    if per_stage_total > limits.max_per_stage_resources {
        return not_supported("Maximum per stage total resource limit exceeded.");
    }
    if per_stage_samplers > limits.max_per_stage_descriptor_samplers {
        return not_supported("Maximum per stage sampler limit exceeded.");
    }
    if per_stage_ubos > limits.max_per_stage_descriptor_uniform_buffers {
        return not_supported("Maximum per stage uniform buffer limit exceeded.");
    }
    if per_stage_ssbos > limits.max_per_stage_descriptor_storage_buffers {
        return not_supported("Maximum per stage storage buffer limit exceeded.");
    }
    if per_stage_sampled > limits.max_per_stage_descriptor_sampled_images {
        return not_supported("Maximum per stage sampled image limit exceeded.");
    }
    if per_stage_storage > limits.max_per_stage_descriptor_storage_images {
        return not_supported("Maximum per stage storage image limit exceeded.");
    }
    if per_stage_input > limits.max_per_stage_descriptor_input_attachments {
        return not_supported("Maximum per stage input attachment limit exceeded.");
    }
    if num_total_iubs > iub_properties.max_descriptor_set_inline_uniform_blocks
        || num_total_iubs > iub_properties.max_per_stage_descriptor_inline_uniform_blocks
    {
        return not_supported("Number of per stage inline uniform blocks exceeds limits.");
    }

    if def.update_after_bind {
        let mut indexing = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        if uses_ubo && indexing.descriptor_binding_uniform_buffer_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingUniformBufferUpdateAfterBind not supported.");
        }
        if uses_sampled && indexing.descriptor_binding_sampled_image_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingSampledImageUpdateAfterBind not supported.");
        }
        if uses_storage_image && indexing.descriptor_binding_storage_image_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingStorageImageUpdateAfterBind not supported.");
        }
        if uses_ssbo && indexing.descriptor_binding_storage_buffer_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingStorageBufferUpdateAfterBind not supported.");
        }
        if uses_utb && indexing.descriptor_binding_uniform_texel_buffer_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingUniformTexelBufferUpdateAfterBind not supported.");
        }
        if uses_stb && indexing.descriptor_binding_storage_texel_buffer_update_after_bind == vk::FALSE {
            return not_supported("descriptorBindingStorageTexelBufferUpdateAfterBind not supported.");
        }
    }

    Ok(())
}

struct DescriptorCopyInstance<'a> {
    context: &'a Context<'a>,
    def: &'static CaseDef,
}

impl DescriptorCopyInstance<'_> {
    /// `DescriptorCommands::updateDescriptorSets`
    fn update_descriptor_sets(&self, resources: &[DescriptorResources<'_>], descriptor_sets: &[vk::DescriptorSet]) {
        let device = self.context.get_device();
        let mut binding_in_set = vec![0u32; self.def.set_count];
        let mut writes = Vec::new();

        // Write descriptors that are marked as needing initialization
        for resource in resources {
            let set = resource.def.set as usize;
            let mut write = resource.descriptor_write();
            write.dst_set = descriptor_sets[set];
            write.dst_binding = binding_in_set[set];
            binding_in_set[set] += 1;
            if write.descriptor_count > 0 {
                writes.push(write);
            }
        }

        let copies: Vec<vk::CopyDescriptorSet> = self
            .def
            .copies
            .iter()
            .map(|copy| vk::CopyDescriptorSet {
                src_set: descriptor_sets[copy.src_set as usize],
                src_binding: copy.src_binding,
                src_array_element: copy.src_element,
                dst_set: descriptor_sets[copy.dst_set as usize],
                dst_binding: copy.dst_binding,
                dst_array_element: copy.dst_element,
                descriptor_count: copy.count,
                ..Default::default()
            })
            .collect();

        unsafe { device.update_descriptor_sets(&writes, &copies) };
    }
}

impl TestInstance for DescriptorCopyInstance<'_> {
    /// `DescriptorCommands::run`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let def = self.def;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();
        let compute = def.pipeline == Pipeline::Compute;
        let shader_stage = if compute {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let result_format = vk::Format::R8G8B8A8_UNORM;
        let uab = def.update_after_bind;

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Initialize all descriptors
        let mut resources = Vec::with_capacity(def.descriptors.len());
        for descriptor in def.descriptors {
            resources.push(DescriptorResources::new(context, descriptor, def.pipeline)?);
        }

        // Descriptor counts per type, as `m_descriptorCounts` keeps them; inline uniform blocks count their bytes in the pool.
        let mut descriptor_counts: BTreeMap<i32, (vk::DescriptorType, u32)> = BTreeMap::new();
        let mut num_total_iubs = 0u32;
        let mut iub_total_bytes = 0u32;
        for descriptor in def.descriptors {
            let ty = descriptor_type(descriptor.kind);
            let count = if descriptor.kind == Kind::Iub {
                1
            } else {
                descriptor.array_size
            };
            descriptor_counts.entry(ty.as_raw()).or_insert((ty, 0)).1 += count;
            if descriptor.kind == Kind::Iub {
                iub_total_bytes += descriptor.array_size * 16;
                num_total_iubs += 1;
            }
        }

        let mut pool_flags = vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET;
        let mut layout_flags = vk::DescriptorSetLayoutCreateFlags::empty();
        let mut binding_flag = vk::DescriptorBindingFlags::empty();
        if uab {
            pool_flags |= vk::DescriptorPoolCreateFlags::UPDATE_AFTER_BIND;
            layout_flags |= vk::DescriptorSetLayoutCreateFlags::UPDATE_AFTER_BIND_POOL;
            binding_flag |= vk::DescriptorBindingFlags::UPDATE_AFTER_BIND;
        }

        // Create descriptor pool
        let descriptor_pool = {
            let pool_sizes: Vec<vk::DescriptorPoolSize> = descriptor_counts
                .values()
                .map(|&(ty, count)| vk::DescriptorPoolSize {
                    type_: ty,
                    descriptor_count: if ty == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
                        iub_total_bytes
                    } else {
                        count
                    },
                })
                .collect();
            let mut iub_pool_info = vk::DescriptorPoolInlineUniformBlockCreateInfo {
                max_inline_uniform_block_bindings: num_total_iubs,
                ..Default::default()
            };
            let mut info = vk::DescriptorPoolCreateInfo::builder()
                .flags(pool_flags)
                .max_sets(def.set_count as u32)
                .pool_sizes(&pool_sizes);
            if num_total_iubs > 0 {
                info = info.push_next(&mut iub_pool_info);
            }
            Unique::new(
                device,
                unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?,
            )
        };

        // Create descriptor set layouts. One for each descriptor set used in this test.
        let mut set_layouts = Vec::with_capacity(def.set_count);
        for set_idx in 0..def.set_count {
            let layout_bindings: Vec<vk::DescriptorSetLayoutBinding> = def
                .descriptors
                .iter()
                .filter(|d| d.set as usize == set_idx)
                .enumerate()
                .map(|(binding_idx, d)| vk::DescriptorSetLayoutBinding {
                    binding: binding_idx as u32,
                    descriptor_type: descriptor_type(d.kind),
                    // Inline uniform blocks have a special meaning for descriptorCount.
                    descriptor_count: if d.kind == Kind::Iub {
                        d.array_size * 16
                    } else {
                        d.array_size
                    },
                    stage_flags: shader_stage,
                    immutable_samplers: std::ptr::null(),
                })
                .collect();
            let bindings_flags = vec![binding_flag; layout_bindings.len()];
            let mut binding_flags_info =
                vk::DescriptorSetLayoutBindingFlagsCreateInfo::builder().binding_flags(&bindings_flags);
            let mut info = vk::DescriptorSetLayoutCreateInfo::builder()
                .flags(layout_flags)
                .bindings(&layout_bindings);
            if uab {
                info = info.push_next(&mut binding_flags_info);
            }
            set_layouts.push(Unique::new(
                device,
                unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?,
            ));
        }

        // Create descriptor sets
        let layout_handles: Vec<vk::DescriptorSetLayout> = set_layouts.iter().map(|layout| **layout).collect();
        let mut descriptor_sets = Vec::with_capacity(def.set_count);
        for layout in &layout_handles {
            let layouts = [*layout];
            let info = vk::DescriptorSetAllocateInfo::builder()
                .descriptor_pool(*descriptor_pool)
                .set_layouts(&layouts);
            descriptor_sets
                .push(unsafe { device.allocate_descriptor_sets(&info) }.vk_check("vkAllocateDescriptorSets")?[0]);
        }

        // Update descriptor sets when this should be done before bind
        if !uab {
            self.update_descriptor_sets(&resources, &descriptor_sets);
        }

        // Create pipeline layout
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&layout_handles);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let result_image;
        let result_image_view;
        let result_image_buffer;
        let render_pass;
        let framebuffer;
        let pipeline;

        if compute {
            let module = create_shader_module(device, binaries.get("compute")?)?;
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*module)
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(0);
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            result_image = None;
            result_image_view = None;
            result_image_buffer = None;
            render_pass = None;
            framebuffer = None;
        } else {
            let queue_family_indices = [queue_family_index];
            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(result_format)
                .extent(vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .queue_family_indices(&queue_family_indices)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                result_format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )?;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize,
                    vk::BufferUsageFlags::TRANSFER_DST,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            // Create render pass: the colour attachment, then one attachment for every input attachment reference
            let input_attachments: Vec<vk::AttachmentReference> = resources
                .iter()
                .filter(|r| r.def.kind == Kind::Input)
                .flat_map(|r| {
                    r.def.attachment_indices.iter().map(|index| vk::AttachmentReference {
                        attachment: index + 1,
                        layout: image_layout(Kind::Input),
                    })
                })
                .collect();
            let color_attachment_ref = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let mut attachment_descriptions = vec![vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: vk::Format::R8G8B8A8_UNORM,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            for _ in 0..input_attachments.len() {
                attachment_descriptions.push(vk::AttachmentDescription {
                    flags: vk::AttachmentDescriptionFlags::empty(),
                    format: vk::Format::R32_SFLOAT,
                    samples: vk::SampleCountFlags::_1,
                    load_op: vk::AttachmentLoadOp::LOAD,
                    store_op: vk::AttachmentStoreOp::DONT_CARE,
                    stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                    stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                    initial_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                });
            }
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&input_attachments)
                .color_attachments(&color_attachment_ref)
                .build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpasses);
            let pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );

            // Create framebuffer: the result image view, then the views of the input attachments
            let mut image_views = vec![*view];
            for resource in &resources {
                image_views.extend(resource.attachment_views());
            }
            let framebuffer_info = vk::FramebufferCreateInfo::builder()
                .render_pass(*pass)
                .attachments(&image_views)
                .width(RENDER_SIZE)
                .height(RENDER_SIZE)
                .layers(1);
            let fb = Unique::new(
                device,
                unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
            );

            // Create graphics pipeline
            let vert = create_shader_module(device, binaries.get("vertex")?)?;
            let frag = create_shader_module(device, binaries.get("fragment")?)?;
            let entry = c"main";
            let stages = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vert)
                    .name(entry.to_bytes_with_nul())
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*frag)
                    .name(entry.to_bytes_with_nul())
                    .build(),
            ];
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: RENDER_SIZE as f32,
                height: RENDER_SIZE as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            }];
            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
                .primitive_restart_enable(false);
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(false)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);
            let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
                .rasterization_samples(vk::SampleCountFlags::_1)
                .sample_shading_enable(false)
                .min_sample_shading(1.0);
            let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
            let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .color_write_mask(
                    vk::ColorComponentFlags::R
                        | vk::ColorComponentFlags::G
                        | vk::ColorComponentFlags::B
                        | vk::ColorComponentFlags::A,
                )
                .build()];
            let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
            let info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .depth_stencil_state(&depth_stencil_state)
                .color_blend_state(&color_blend_state)
                .layout(*pipeline_layout)
                .render_pass(*pass)
                .subpass(0);
            pipeline = crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)?;

            result_image = Some(image);
            result_image_view = Some(view);
            result_image_buffer = Some(buffer);
            render_pass = Some(pass);
            framebuffer = Some(fb);
        }

        // Run verification shader
        {
            let bind_point = if compute {
                vk::PipelineBindPoint::COMPUTE
            } else {
                vk::PipelineBindPoint::GRAPHICS
            };
            let has_dynamic_areas = def.descriptors.iter().any(|d| is_dynamic(d.kind));
            let offsets: Vec<u32> = if has_dynamic_areas {
                def.dynamic_areas.iter().map(|area| area * 256).collect()
            } else {
                Vec::new()
            };

            begin_command_buffer(device, cmd)?;

            if !compute {
                let clear_values = [vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [1.0, 0.0, 0.0, 1.0],
                    },
                }];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(**render_pass.as_ref().expect("graphics case has a render pass"))
                    .framebuffer(**framebuffer.as_ref().expect("graphics case has a framebuffer"))
                    .render_area(vk::Rect2D {
                        offset: vk::Offset2D { x: 0, y: 0 },
                        extent: vk::Extent2D {
                            width: RENDER_SIZE,
                            height: RENDER_SIZE,
                        },
                    })
                    .clear_values(&clear_values);
                unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
            }

            unsafe {
                device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
                device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &descriptor_sets, &offsets);
            }

            // Update descriptor sets when this should be done after bind
            if uab {
                self.update_descriptor_sets(&resources, &descriptor_sets);
            }

            if compute {
                unsafe { device.cmd_dispatch(cmd, 1, 1, 1) };
            } else {
                unsafe {
                    device.cmd_draw(cmd, 6, 1, 0, 0);
                    device.cmd_end_render_pass(cmd);
                }
                copy_image_to_buffer(
                    device,
                    cmd,
                    result_image.as_ref().expect("graphics case has a result image").get(),
                    result_image_buffer
                        .as_ref()
                        .expect("graphics case has a result buffer")
                        .get(),
                    RENDER_SIZE,
                    RENDER_SIZE,
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        let _ = &result_image_view;

        if compute {
            // The result buffer is the last descriptor added, always a storage buffer in set 0.
            let result = resources.last().expect("compute cases end with the result buffer");
            let Backing::Buffer { buffer, .. } = &result.backing else {
                return Err(TestError::InternalError(
                    "the result descriptor is not a buffer".to_string(),
                ));
            };
            invalidate_alloc(device, buffer.get_allocation())?;
            let data = unsafe { std::ptr::read_unaligned(buffer.get_allocation().get_host_ptr() as *const i32) };
            if data == 1 {
                Ok(TestStatus::pass("Pass"))
            } else {
                Ok(TestStatus::fail("Data validation failed"))
            }
        } else {
            let buffer = result_image_buffer.as_ref().expect("graphics case has a result buffer");
            invalidate_alloc(device, buffer.get_allocation())?;
            let bytes = unsafe {
                std::slice::from_raw_parts(
                    buffer.get_allocation().get_host_ptr() as *const u8,
                    (RENDER_SIZE * RENDER_SIZE * 4) as usize,
                )
            };
            if bytes.chunks_exact(4).any(|pixel| pixel != [0, 255, 0, 255]) {
                return Ok(TestStatus::fail("Result image validation failed"));
            }
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `CopyImmutableSamplerCase`: combined image samplers with an immutable sampler (and a storage buffer before or after them) copied to a second
/// set whose storage buffer was written normally; each quadrant must show its own image colour with the red value of its set.
struct CopyImmutableSamplerCase {
    def: &'static ImmutableSamplerDef,
}

impl TestCase for CopyImmutableSamplerCase {
    fn name(&self) -> &str {
        self.def.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImmutableSamplerInstance { context, def: self.def })
    }
}

struct CopyImmutableSamplerInstance<'a> {
    context: &'a Context<'a>,
    def: &'static ImmutableSamplerDef,
}

impl TestInstance for CopyImmutableSamplerInstance<'_> {
    /// `CopyImmutableSamplerTest::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let sampler_count = self.def.sampler_count;
        let buffer_first = self.def.buffer_first;
        let image_format = vk::Format::R8G8B8A8_UNORM;
        let fb_size = 2u32;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let buffer_binding = if buffer_first { 0 } else { sampler_count };
        let img_binding_offset = if buffer_first { 1 } else { 0 };

        // We will create `sampler_count` combined image samplers with an immutable sampler.
        let sampler_info = vk::SamplerCreateInfo::default();
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let mut images = Vec::new();
        let mut image_views = Vec::new();
        for _ in 0..sampler_count {
            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(image_format)
                .extent(vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
            image_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                color_range,
            )?);
            images.push(image);
        }

        // Now a storage buffer that contains different red values.
        let red_values: [f32; 8] = [0.5, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0];
        // VUID-VkWriteDescriptorSet-descriptorType-00328
        let min_alignment = context
            .get_device_properties()
            .limits
            .min_storage_buffer_offset_alignment;
        let raw_buffer_size = std::mem::size_of_val(&red_values) as vk::DeviceSize;
        let aligned_half_size = (raw_buffer_size / 2).div_ceil(min_alignment) * min_alignment;
        let red_buffer_size = aligned_half_size * 2;
        let red_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(red_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = red_buffer.get_allocation();
            let buffer_ptr = alloc.get_host_ptr();
            let half_bytes = (raw_buffer_size / 2) as usize;
            // First half (0.5 values) at offset 0, second half (1.0 values) at the aligned offset
            unsafe {
                std::ptr::copy_nonoverlapping(red_values.as_ptr().cast::<u8>(), buffer_ptr, half_bytes);
                std::ptr::copy_nonoverlapping(
                    red_values.as_ptr().add(4).cast::<u8>(),
                    buffer_ptr.add(aligned_half_size as usize),
                    half_bytes,
                );
            }
            flush_alloc(device, alloc)?;
        }

        // We also need a framebuffer and a vertex buffer.
        let fb_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(image_format)
            .extent(vk::Extent3D {
                width: fb_size,
                height: fb_size,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, fb_image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            image_format,
            color_range,
        )?;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (fb_size * fb_size * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let vertices: [[f32; 4]; 4] = [
            [-0.5, -0.5, 0.0, 1.0],
            [-0.5, 0.5, 0.0, 1.0],
            [0.5, -0.5, 0.0, 1.0],
            [0.5, 0.5, 0.0, 1.0],
        ];
        let vert_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&vertices) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = vert_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    std::mem::size_of_val(&vertices),
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Descriptor pool and descriptor sets.
        const SET_COUNT: u32 = 2;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, sampler_count * SET_COUNT)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, SET_COUNT)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, SET_COUNT)?;

        let mut layout_bindings = Vec::new();
        let sampler_ptr: *const vk::Sampler = &*sampler;
        let buffer_layout_binding = |binding: u32| vk::DescriptorSetLayoutBinding {
            binding,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            immutable_samplers: std::ptr::null(),
        };
        if buffer_first {
            layout_bindings.push(buffer_layout_binding(0));
        }
        for i in 0..sampler_count {
            layout_bindings.push(vk::DescriptorSetLayoutBinding {
                binding: i + img_binding_offset,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                immutable_samplers: sampler_ptr,
            });
        }
        if !buffer_first {
            layout_bindings.push(buffer_layout_binding(sampler_count));
        }
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&layout_bindings);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let set_layouts = [*set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let first_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let second_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        // Update the first descriptor set manually.
        {
            let image_infos: Vec<vk::DescriptorImageInfo> = image_views
                .iter()
                .map(|view| vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: **view,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                })
                .collect();
            let mut writes: Vec<vk::WriteDescriptorSet> = image_infos
                .iter()
                .enumerate()
                .map(|(i, info)| vk::WriteDescriptorSet {
                    dst_set: *first_set,
                    dst_binding: i as u32 + img_binding_offset,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    image_info: info,
                    ..Default::default()
                })
                .collect();
            let buffer_info = make_descriptor_buffer_info(red_buffer.get(), 0, aligned_half_size);
            writes.push(vk::WriteDescriptorSet {
                dst_set: *first_set,
                dst_binding: buffer_binding,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                buffer_info: &buffer_info,
                ..Default::default()
            });
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Copy combined image sampler descriptors to the second set.
        {
            // First, write the red buffer descriptor info.
            let buffer_info = make_descriptor_buffer_info(red_buffer.get(), aligned_half_size, aligned_half_size);
            let write = vk::WriteDescriptorSet {
                dst_set: *second_set,
                dst_binding: buffer_binding,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                buffer_info: &buffer_info,
                ..Default::default()
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            // Then, copy the immutable sampler descriptors, all at the same time.
            let copy = vk::CopyDescriptorSet {
                src_set: *first_set,
                src_binding: img_binding_offset,
                src_array_element: 0,
                dst_set: *second_set,
                dst_binding: img_binding_offset,
                dst_array_element: 0,
                descriptor_count: sampler_count,
                ..Default::default()
            };
            unsafe { device.update_descriptor_sets(&[] as &[vk::WriteDescriptorSet], &[copy]) };
        }

        // Create pipeline.
        let render_pass = make_render_pass(device, image_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], fb_size, fb_size, 1)?;
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let stages = GraphicsPipelineStages {
            vertex: *vert_shader,
            fragment: *frag_shader,
            tessellation_control: None,
            tessellation_evaluation: None,
            geometry: None,
        };
        let pipeline = make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            stages,
            *render_pass,
            (fb_size, fb_size),
            vk::PrimitiveTopology::POINT_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        // Colors for each image, plus the clear color.
        let image_colors: [[f32; 4]; 5] = [
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
            [0.0, 0.0, 0.0, 0.0],
        ];

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        // Prepare images.
        {
            let pre_clear_barriers: Vec<vk::ImageMemoryBarrier> = images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        image.get(),
                        color_range,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_clear_barriers,
                );
                for (i, image) in images.iter().enumerate() {
                    let clear_color = vk::ClearColorValue {
                        float32: image_colors[i],
                    };
                    device.cmd_clear_color_image(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_color,
                        &[color_range],
                    );
                }
            }
            let post_clear_barriers: Vec<vk::ImageMemoryBarrier> = images
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        image.get(),
                        color_range,
                    )
                })
                .collect();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_clear_barriers,
                );
            }
        }
        // Draw half the vertices with the first set and the other half with the other set.
        {
            let half_vertex_count = (vertices.len() / 2) as u32;
            let bind_point = vk::PipelineBindPoint::GRAPHICS;
            let clear_values = [vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: image_colors[4],
                },
            }];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: fb_size,
                        height: fb_size,
                    },
                })
                .clear_values(&clear_values);
            unsafe {
                device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vert_buffer.get()], &[0]);
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[*first_set], &[] as &[u32]);
                device.cmd_draw(cmd, half_vertex_count, 1, 0, 0);
                device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[*second_set], &[] as &[u32]);
                device.cmd_draw(cmd, half_vertex_count, 1, half_vertex_count, 0);
                device.cmd_end_render_pass(cmd);
            }
        }
        copy_image_to_buffer(device, cmd, color_image.get(), color_buffer.get(), fb_size, fb_size);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Reference: each quadrant has its own colour according to the shader, in a row major 2x2 image.
        let first_offset = red_values[0];
        let second_offset = red_values[red_values.len() / 2];
        let with_red = |color: [f32; 4], red: f32| [color[0] + red, color[1], color[2], color[3]];
        let reference: [[f32; 4]; 4] = if sampler_count == 1 {
            [
                with_red(image_colors[0], first_offset),
                with_red(image_colors[0], second_offset),
                with_red(image_colors[0], first_offset),
                with_red(image_colors[0], second_offset),
            ]
        } else {
            [
                with_red(image_colors[0], first_offset),
                with_red(image_colors[2], second_offset),
                with_red(image_colors[1], first_offset),
                with_red(image_colors[3], second_offset),
            ]
        };

        invalidate_alloc(device, color_buffer.get_allocation())?;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr() as *const u8,
                (fb_size * fb_size * 4) as usize,
            )
        };
        // 1/255 < 0.005 < 2/255
        let threshold = 0.005f32;
        for (pixel, expected) in bytes.chunks_exact(4).zip(reference.iter()) {
            for channel in 0..4 {
                let value = f32::from(pixel[channel]) / 255.0;
                if (value - expected[channel].clamp(0.0, 1.0)).abs() > threshold {
                    return Ok(TestStatus::fail("Unexpected result in color buffer"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDescriptorCopyTests`
pub fn create_descriptor_copy_tests() -> TestCaseGroup {
    let mut descriptor_copy_group = TestCaseGroup::new("descriptor_copy");

    for group_name in ["compute", "graphics", "graphics_uab"] {
        let mut group = TestCaseGroup::new(group_name);
        for def in CASES.iter().filter(|def| def.group == group_name) {
            group.add_child(Box::new(DescriptorCopyCase { def }) as Box<dyn TestCase>);
        }
        descriptor_copy_group.add_child(group);
    }

    let mut misc_group = TestCaseGroup::new("misc");
    for def in IMMUTABLE_SAMPLER_CASES {
        misc_group.add_child(Box::new(CopyImmutableSamplerCase { def }) as Box<dyn TestCase>);
    }
    descriptor_copy_group.add_child(misc_group);

    descriptor_copy_group
}
