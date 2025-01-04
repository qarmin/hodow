// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryOpaqueAndDmaImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of the `sample` cases are `shaders/manifest/memory_opaque_and_dma.toml` (the extent is always 64x64).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrExternalMemoryFdExtensionDeviceCommands};

use crate::generated::shaders::memory_opaque_and_dma::OPAQUE_AND_DMA_SAMPLE_PROGRAMS;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_graphics_pipeline, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: u32 = 64;
const BOTH_HANDLE_TYPES: [vk::ExternalMemoryHandleTypeFlags; 2] = [
    vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
    vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
];

/// `Params`
#[derive(Clone, Copy)]
struct Params {
    format: vk::Format,
    /// If true, sample the imported image. If false, copy it to a buffer.
    sample: bool,
}

impl Params {
    /// `getRandomSeed`
    fn random_seed(&self) -> u32 {
        (self.format.as_raw() as u32) | (u32::from(self.sample) << 31)
    }

    /// `getUsage`
    fn usage(&self) -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
            | if self.sample {
                vk::ImageUsageFlags::SAMPLED
            } else {
                vk::ImageUsageFlags::empty()
            }
    }

    /// `getRequiredFeatures`
    fn required_features(&self) -> vk::FormatFeatureFlags {
        if self.sample {
            vk::FormatFeatureFlags::SAMPLED_IMAGE
        } else {
            vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST
        }
    }
}

/// `getCompatibleDrmModifier`: the first modifier that has the features, with its plane count.
#[expect(
    unused_assignments,
    reason = "read by the driver through the pointer chain of the structure it is stored in"
)]
fn get_compatible_drm_modifier(
    context: &Context<'_>,
    format: vk::Format,
    required: vk::FormatFeatureFlags,
) -> Option<(u64, u32)> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut modifier_list = vk::DrmFormatModifierPropertiesListEXT::default();
    let mut format_properties = vk::FormatProperties2::default();
    format_properties.next = std::ptr::addr_of_mut!(modifier_list).cast();
    unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };

    if modifier_list.drm_format_modifier_count == 0 {
        return None;
    }

    let mut modifier_properties =
        vec![vk::DrmFormatModifierPropertiesEXT::default(); modifier_list.drm_format_modifier_count as usize];
    modifier_list.drm_format_modifier_properties = modifier_properties.as_mut_ptr();
    unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };

    modifier_properties
        .iter()
        .find(|properties| properties.drm_format_modifier_tiling_features.contains(required))
        .map(|properties| {
            (
                properties.drm_format_modifier,
                properties.drm_format_modifier_plane_count,
            )
        })
}

/// `getExternalMemoryProperties`
fn get_external_memory_properties(
    context: &Context<'_>,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    modifier: u64,
) -> Result<vk::ExternalMemoryProperties, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT::default();
    modifier_info.drm_format_modifier = modifier;

    let mut external_image_format_info = vk::PhysicalDeviceExternalImageFormatInfo::default();
    external_image_format_info.next = std::ptr::addr_of!(modifier_info).cast();
    external_image_format_info.handle_type = handle_type;

    let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2::default();
    image_format_info.next = std::ptr::addr_of!(external_image_format_info).cast();
    image_format_info.format = format;
    image_format_info.type_ = vk::ImageType::_2D;
    image_format_info.tiling = vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT;
    image_format_info.usage = usage;

    let mut external_format_properties = vk::ExternalImageFormatProperties::default();
    let mut format_properties = vk::ImageFormatProperties2::default();
    format_properties.next = std::ptr::addr_of_mut!(external_format_properties).cast();

    let result = unsafe {
        instance.get_physical_device_image_format_properties2(
            physical_device,
            &image_format_info,
            &mut format_properties,
        )
    };
    match result {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) | Err(vk::ErrorCode::IMAGE_USAGE_NOT_SUPPORTED_KHR) => Err(
            TestError::NotSupported("Format not supported for intended usage, tiling or handle type".to_string()),
        ),
        other => {
            other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
            Ok(external_format_properties.external_memory_properties)
        }
    }
}

fn handle_type_name(handle_type: vk::ExternalMemoryHandleTypeFlags) -> &'static str {
    if handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD {
        "opaque_fd"
    } else {
        "dma_buf"
    }
}

struct OpaqueAndDmaCase {
    name: String,
    params: Params,
}

impl TestCase for OpaqueAndDmaCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        for extension in [
            "VK_KHR_external_memory",
            "VK_KHR_external_memory_fd",
            "VK_EXT_external_memory_dma_buf",
            "VK_EXT_image_drm_format_modifier",
            "VK_KHR_maintenance1",
        ] {
            context.require_device_functionality(extension)?;
        }

        let format = self.params.format;
        let usage = self.params.usage();

        // We need a DRM format modifier that supports the features we need.
        let Some((modifier, _plane_count)) =
            get_compatible_drm_modifier(context, format, self.params.required_features())
        else {
            return Err(TestError::NotSupported(format!(
                "{format:?} does not have a DRM modifier which supports the required features"
            )));
        };

        let both_handle_types = [
            vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
            vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ];
        let mut compatible = false;

        for (i, &handle_type) in both_handle_types.iter().enumerate() {
            let other_handle_type = both_handle_types[1 - i];
            let memory_properties = get_external_memory_properties(context, handle_type, format, usage, modifier)?;

            if !memory_properties
                .external_memory_features
                .contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE)
            {
                return Err(TestError::NotSupported(format!(
                    "Handles of type {} cannot be imported",
                    handle_type_name(handle_type)
                )));
            }

            // Finding the other handle type in one of the flag fields is good enough.
            if memory_properties.compatible_handle_types.intersects(other_handle_type) {
                compatible = true;
            }
        }

        if !compatible {
            return Err(TestError::NotSupported(
                "OPAQUE_FD not compatible with DMA_BUF".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.sample {
            OPAQUE_AND_DMA_SAMPLE_PROGRAMS.programs
        } else {
            BinaryCollection::new(&[])
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OpaqueAndDmaInstance {
            context,
            params: self.params,
        })
    }
}

struct OpaqueAndDmaInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `runTest`
fn run_test(context: &Context<'_>, params: Params) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();
    let format = params.format;
    let usage = params.usage();
    let extent = vk::Extent3D {
        width: EXTENT,
        height: EXTENT,
        depth: 1,
    };
    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(extent, color_layers);
    let threshold = [0.005f32, 0.005, 0.005, 0.0];

    let both_handle_types_mask = BOTH_HANDLE_TYPES[0] | BOTH_HANDLE_TYPES[1];

    let (modifier, plane_count) = get_compatible_drm_modifier(context, format, params.required_features())
        .ok_or_else(|| TestError::InternalError("no compatible DRM format modifier".to_string()))?;

    let drm_modifier_create_info = vk::ImageDrmFormatModifierListCreateInfoEXT {
        drm_format_modifier_count: 1,
        drm_format_modifiers: &raw const modifier,
        ..Default::default()
    };
    let external_memory_create_info = vk::ExternalMemoryImageCreateInfo {
        next: (&raw const drm_modifier_create_info).cast(),
        handle_types: both_handle_types_mask,
        ..Default::default()
    };
    let make_image_create_info = |next: *const std::ffi::c_void| vk::ImageCreateInfo {
        next,
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
        ..Default::default()
    };
    let src_image_info = make_image_create_info((&raw const external_memory_create_info).cast());
    let src_image = Unique::new(
        device,
        unsafe { device.create_image(&src_image_info, None) }.vk_check("vkCreateImage")?,
    );
    let mem_reqs = unsafe { device.get_image_memory_requirements(*src_image) };

    // Select the first available memory type.
    let selected_memory_type = (0..32u32)
        .find(|&index| mem_reqs.memory_type_bits & (1 << index) != 0)
        .ok_or_else(|| TestError::InternalError("no memory type for the image".to_string()))?;

    let opaque_fd_memory_properties = get_external_memory_properties(
        context,
        vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
        format,
        usage,
        modifier,
    )?;
    let dma_buf_memory_properties = get_external_memory_properties(
        context,
        vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        format,
        usage,
        modifier,
    )?;
    let requires_dedicated = opaque_fd_memory_properties
        .external_memory_features
        .contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY)
        || dma_buf_memory_properties
            .external_memory_features
            .contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY);

    let dedicated_to_src = vk::MemoryDedicatedAllocateInfo {
        image: *src_image,
        ..Default::default()
    };
    let dedicated_ptr: *const std::ffi::c_void = if requires_dedicated {
        (&raw const dedicated_to_src).cast()
    } else {
        std::ptr::null()
    };

    // This is the key for these tests: the memory is allocated with both opaque fd and DMA buffer export handle types.
    let export_memory_allocate_info = vk::ExportMemoryAllocateInfo {
        next: dedicated_ptr,
        handle_types: both_handle_types_mask,
        ..Default::default()
    };
    let memory_allocate_info = vk::MemoryAllocateInfo {
        next: (&raw const export_memory_allocate_info).cast(),
        allocation_size: mem_reqs.size,
        memory_type_index: selected_memory_type,
        ..Default::default()
    };
    let device_memory = Unique::new(
        device,
        unsafe { device.allocate_memory(&memory_allocate_info, None) }.vk_check("vkAllocateMemory")?,
    );
    unsafe { device.bind_image_memory(*src_image, *device_memory, 0) }.vk_check("vkBindImageMemory")?;

    // Create a source buffer with pixel data and copy data to the image with it.
    let mut rng = Random::new(params.random_seed());
    let tcu_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("texture format of {format:?}")))?;
    let mut reference_level = crate::tcu::pixel::TextureLevel::new(tcu_format, EXTENT, EXTENT, 1)?;
    {
        let mut reference = reference_level.get_access();
        for y in 0..EXTENT {
            for x in 0..EXTENT {
                let red = rng.get_float();
                let green = rng.get_float();
                let blue = rng.get_float();
                reference.set_pixel([red, green, blue, 1.0], x, y, 0);
            }
        }
    }

    let buffer_size = (EXTENT * EXTENT * 4) as vk::DeviceSize;
    let buffer_usage = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    let src_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, buffer_usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            reference_level.data().as_ptr(),
            src_buffer.get_allocation().get_host_ptr(),
            buffer_size as usize,
        );
    }
    flush_alloc(device, src_buffer.get_allocation())?;

    // Copy data to the source image.
    let read_layout = if params.sample {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };

    {
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;

        let pre_copy = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *src_image,
            color_range,
        );
        let post_copy = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::empty(),
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            read_layout,
            *src_image,
            color_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_copy],
            );
            device.cmd_copy_buffer_to_image(
                cmd,
                src_buffer.get(),
                *src_image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_copy],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // Query subresource layouts, which will be needed later.
    let plane_aspects = [
        vk::ImageAspectFlags::MEMORY_PLANE_0_EXT,
        vk::ImageAspectFlags::MEMORY_PLANE_1_EXT,
        vk::ImageAspectFlags::MEMORY_PLANE_2_EXT,
        vk::ImageAspectFlags::MEMORY_PLANE_3_EXT,
    ];
    if plane_count as usize > plane_aspects.len() {
        return Ok(TestStatus::fail("Plane count too large"));
    }

    let mut plane_layouts = Vec::with_capacity(plane_count as usize);
    for aspect_mask in plane_aspects.iter().take(plane_count as usize) {
        let subresource = vk::ImageSubresource {
            aspect_mask: *aspect_mask,
            mip_level: 0,
            array_layer: 0,
        };
        plane_layouts.push(unsafe { device.get_image_subresource_layout(*src_image, &subresource) });
    }

    // Fix info that will be used later.
    for plane_layout in &mut plane_layouts {
        plane_layout.size = 0; // VUID-VkImageDrmFormatModifierExplicitCreateInfoEXT-size-02267
        plane_layout.array_pitch = 0; // VUID-VkImageDrmFormatModifierExplicitCreateInfoEXT-arrayPitch-02268
        plane_layout.depth_pitch = 0; // VUID-VkImageDrmFormatModifierExplicitCreateInfoEXT-depthPitch-02269
    }

    // Now we need to export the image memory as both handle types, import it and try to see if contents match.
    let mut fail = false;

    for handle_type in BOTH_HANDLE_TYPES {
        // Create image first with explicit modifier info and plane layout information.
        let explicit_modifier_info = vk::ImageDrmFormatModifierExplicitCreateInfoEXT {
            drm_format_modifier: modifier,
            drm_format_modifier_plane_count: plane_layouts.len() as u32,
            plane_layouts: plane_layouts.as_ptr(),
            ..Default::default()
        };
        // Redo the creation chain.
        let explicit_external_memory_create_info = vk::ExternalMemoryImageCreateInfo {
            next: (&raw const explicit_modifier_info).cast(),
            handle_types: both_handle_types_mask,
            ..Default::default()
        };
        let dst_image_info = make_image_create_info((&raw const explicit_external_memory_create_info).cast());
        let dst_image = Unique::new(
            device,
            unsafe { device.create_image(&dst_image_info, None) }.vk_check("vkCreateImage")?,
        );

        // Obtain memory fd.
        let get_fd_info = vk::MemoryGetFdInfoKHR {
            memory: *device_memory,
            handle_type,
            ..Default::default()
        };
        let fd = unsafe { device.get_memory_fd_khr(&get_fd_info) }.vk_check("vkGetMemoryFdKHR")?;
        if fd < 0 {
            return Ok(TestStatus::fail("Got invalid file descriptor"));
        }

        // Import the previous memory object as memory for the image, including the dedicated allocation info if needed.
        let dedicated_to_dst = vk::MemoryDedicatedAllocateInfo {
            image: *dst_image,
            ..Default::default()
        };
        let dedicated_ptr: *const std::ffi::c_void = if requires_dedicated {
            (&raw const dedicated_to_dst).cast()
        } else {
            std::ptr::null()
        };
        let memory_fd_info = vk::ImportMemoryFdInfoKHR {
            next: dedicated_ptr,
            handle_type,
            fd,
            ..Default::default()
        };
        let import_allocate_info = vk::MemoryAllocateInfo {
            next: (&raw const memory_fd_info).cast(),
            allocation_size: mem_reqs.size,
            memory_type_index: selected_memory_type,
            ..Default::default()
        };

        // Create and bind to dst image.
        let imported_memory = Unique::new(
            device,
            unsafe { device.allocate_memory(&import_allocate_info, None) }.vk_check("vkAllocateMemory")?,
        );
        unsafe { device.bind_image_memory(*dst_image, *imported_memory, 0) }.vk_check("vkBindImageMemory")?;

        let result_bytes: Vec<u8> = if params.sample {
            let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
            let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, format, color_usage, 4)?;

            let render_pass = make_render_pass(device, format)?;
            let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

            let sampler_info = vk::SamplerCreateInfo {
                mag_filter: vk::Filter::NEAREST,
                min_filter: vk::Filter::NEAREST,
                mipmap_mode: vk::SamplerMipmapMode::NEAREST,
                address_mode_u: vk::SamplerAddressMode::REPEAT,
                address_mode_v: vk::SamplerAddressMode::REPEAT,
                address_mode_w: vk::SamplerAddressMode::REPEAT,
                mip_lod_bias: 0.0,
                anisotropy_enable: vk::FALSE,
                max_anisotropy: 1.0,
                compare_enable: vk::FALSE,
                compare_op: vk::CompareOp::NEVER,
                min_lod: 0.0,
                max_lod: 0.0,
                border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
                unnormalized_coordinates: vk::FALSE,
                ..Default::default()
            };
            let sampler = Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            );

            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    vk::ShaderStageFlags::FRAGMENT,
                )
                .build(device)?;
            let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

            let dst_image_view = make_image_view(device, *dst_image, vk::ImageViewType::_2D, format, color_range)?;

            // We will sample the dst image.
            let image_info = vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *dst_image_view,
                image_layout: read_layout,
            };
            let write = vk::WriteDescriptorSet {
                dst_set: descriptor_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: &image_info,
                ..Default::default()
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            let binaries = context.get_binary_collection();
            let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
            let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
            let pipeline = make_graphics_pipeline(
                device,
                *pipeline_layout,
                *vert_shader,
                *frag_shader,
                *render_pass,
                (EXTENT, EXTENT),
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?;

            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;
            begin_command_buffer(device, cmd)?;

            let prepare_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ,
                read_layout,
                read_layout,
                *dst_image,
                color_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[prepare_barrier],
                );
            }

            let clear_value = vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            };
            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, EXTENT, EXTENT),
                clear_value,
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
                device.cmd_draw(cmd, 3, 1, 0, 0); // Fixed triangle. See vertex shader.
            }
            end_render_pass(device, cmd);

            copy_image_to_buffer(
                device,
                cmd,
                color_buffer.image.get(),
                color_buffer.buffer.get(),
                EXTENT,
                EXTENT,
            );

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            color_buffer.read_bytes(device)?.to_vec()
        } else {
            let dst_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size, buffer_usage),
                MemoryRequirement::HOST_VISIBLE,
            )?;

            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;
            begin_command_buffer(device, cmd)?;

            let prepare_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ,
                read_layout,
                read_layout,
                *dst_image,
                color_range,
            );
            let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[prepare_barrier],
                );
                // Copy the imported image to a buffer.
                device.cmd_copy_image_to_buffer(cmd, *dst_image, read_layout, dst_buffer.get(), &[copy_region]);
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

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;

            invalidate_alloc(device, dst_buffer.get_allocation())?;
            unsafe { std::slice::from_raw_parts(dst_buffer.get_allocation().get_host_ptr(), buffer_size as usize) }
                .to_vec()
        };

        // We need to check it has preserved contents.
        let result = ConstPixelBufferAccess::new(tcu_format, [EXTENT, EXTENT, 1], &result_bytes);
        let comparison = float_threshold_compare(&reference_level.get_const_access(), &result, threshold);
        if !comparison.ok {
            log::error!(
                "{}: image comparison failed, max difference {:?}",
                handle_type_name(handle_type),
                comparison.max_diff
            );
            fail = true;
        }
    }

    if fail {
        return Ok(TestStatus::fail(
            "Unexpected results in imported memory image; check log for details --",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

impl TestInstance for OpaqueAndDmaInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_test(self.context, self.params)
    }
}

/// `createOpaqueAndDmaImageTests`
pub fn create_opaque_and_dma_image_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("opaque_and_dma");

    for (format, format_name) in [
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm"),
    ] {
        for sample in [false, true] {
            group.add_child(Box::new(OpaqueAndDmaCase {
                name: format!("{format_name}_{}", if sample { "sample" } else { "transfer" }),
                params: Params { format, sample },
            }) as Box<dyn TestCase>);
        }
    }

    group
}
