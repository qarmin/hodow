// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/modifiers/vktModifiersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. Ported: `list_modifiers`, `list_modifiers_fmt_features2`, `list_modifiers_consistency`,
// `create_list_modifiers`, `create_list_modifiers_fmt_features2`, `create_explicit_modifier`, `create_explicit_modifier_fmt_features2` and `bound_to_dma_buf`. `export_import*` (`MultiQueueRunnerTestInstance` over the external memory utilities) are ported too. The failure logs are dropped,
// and an error other than FORMAT_NOT_SUPPORTED from vkGetPhysicalDeviceImageFormatProperties2 fails the case (upstream reads the unwritten result).

use std::collections::BTreeMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, ExtImageDrmFormatModifierExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::image_compare::int_threshold_compare;
use crate::tcu::pixel::{
    ConstPixelBufferAccess, PixelBufferAccess, fill_with_component_gradients2, get_texture_format_info,
};
use crate::tcu::texture::map_vk_format;
use crate::tcu::vector::UVec4;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::image::host_image_copy_layout_tests::{queues_for, run_on_queues};
use crate::vkt::tests::image::subresource_layout_tests::{BASIC_COLOR_FORMATS, short_format_name};
use crate::vkt::tests::util::external_memory_util::{
    DedicatedTo, allocate_exportable_memory, choose_memory_type, get_memory_native, import_memory,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_EXTENT: u32 = 64;

/// `VkDrmFormatModifierPropertiesEXT` and `VkDrmFormatModifierProperties2EXT` as one
#[derive(Clone, Copy)]
struct ModifierProps {
    modifier: u64,
    plane_count: u32,
    tiling_features: u64,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Family {
    ListModifiers,
    ListModifiersFmtFeatures2,
    Consistency,
    CreateList,
    CreateListFmtFeatures2,
    BoundToDmaBuf,
    CreateExplicit,
    CreateExplicitFmtFeatures2,
    ExportImport,
    ExportImportFmtFeatures2,
    ExportImportWithSuballoc,
    ExportImportFmtFeatures2WithSuballoc,
}

impl Family {
    fn uses_list2(self) -> bool {
        matches!(
            self,
            Self::ListModifiersFmtFeatures2
                | Self::Consistency
                | Self::CreateListFmtFeatures2
                | Self::CreateExplicitFmtFeatures2
                | Self::ExportImportFmtFeatures2
                | Self::ExportImportFmtFeatures2WithSuballoc
        )
    }

    fn is_export_import(self) -> bool {
        matches!(
            self,
            Self::ExportImport
                | Self::ExportImportFmtFeatures2
                | Self::ExportImportWithSuballoc
                | Self::ExportImportFmtFeatures2WithSuballoc
        )
    }
}

/// `checkModifiersSupported`
fn check_modifiers_supported(context: &Context<'_>, format: vk::Format) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_image_drm_format_modifier")?;
    context.require_device_functionality("VK_KHR_bind_memory2")?;
    context.require_device_functionality("VK_KHR_image_format_list")?;
    if format == vk::Format::A8_UNORM || format == vk::Format::A1B5G5R5_UNORM_PACK16 {
        context.require_device_functionality("VK_KHR_maintenance5")?;
    }
    Ok(())
}

/// `checkModifiersList2Supported`
fn check_modifiers_list2_supported(context: &Context<'_>, format: vk::Format) -> Result<(), TestError> {
    check_modifiers_supported(context, format)?;
    context.require_device_functionality("VK_KHR_format_feature_flags2")
}

/// `getDrmFormatModifiers`, over either structure
#[allow(unused_assignments)]
fn get_drm_format_modifiers(context: &Context<'_>, format: vk::Format, list2: bool) -> Vec<ModifierProps> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let mut format_properties = vk::FormatProperties2::default();

    if list2 {
        let mut modifier_list = vk::DrmFormatModifierPropertiesList2EXT::default();
        format_properties.next = std::ptr::addr_of_mut!(modifier_list).cast();
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };
        let mut properties =
            vec![vk::DrmFormatModifierProperties2EXT::default(); modifier_list.drm_format_modifier_count as usize];
        modifier_list.drm_format_modifier_properties = properties.as_mut_ptr();
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };
        properties
            .iter()
            .map(|props| ModifierProps {
                modifier: props.drm_format_modifier,
                plane_count: props.drm_format_modifier_plane_count,
                tiling_features: props.drm_format_modifier_tiling_features.bits(),
            })
            .collect()
    } else {
        let mut modifier_list = vk::DrmFormatModifierPropertiesListEXT::default();
        format_properties.next = std::ptr::addr_of_mut!(modifier_list).cast();
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };
        let mut properties =
            vec![vk::DrmFormatModifierPropertiesEXT::default(); modifier_list.drm_format_modifier_count as usize];
        modifier_list.drm_format_modifier_properties = properties.as_mut_ptr();
        unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };
        properties
            .iter()
            .map(|props| ModifierProps {
                modifier: props.drm_format_modifier,
                plane_count: props.drm_format_modifier_plane_count,
                tiling_features: u64::from(props.drm_format_modifier_tiling_features.bits()),
            })
            .collect()
    }
}

/// `isModifierCompatibleWithImageProperties`
fn is_modifier_compatible_with_image_properties(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    modifier: u64,
    required_features: vk::ExternalMemoryFeatureFlags,
) -> Result<Option<vk::ImageFormatProperties>, TestError> {
    let mut modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT::default();
    modifier_info.drm_format_modifier = modifier;
    modifier_info.sharing_mode = vk::SharingMode::EXCLUSIVE;

    let mut external_info = vk::PhysicalDeviceExternalImageFormatInfo::default();
    external_info.next = std::ptr::addr_of!(modifier_info).cast();
    external_info.handle_type = handle_type;

    let formats = [format];
    let mut format_list_info = vk::ImageFormatListCreateInfo::default();
    format_list_info.next = std::ptr::addr_of!(external_info).cast();
    format_list_info.view_format_count = 1;
    format_list_info.view_formats = formats.as_ptr();

    let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2::default();
    image_format_info.next = std::ptr::addr_of!(format_list_info).cast();
    image_format_info.format = format;
    image_format_info.type_ = vk::ImageType::_2D;
    image_format_info.tiling = vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT;
    image_format_info.usage = usage;

    let mut external_properties = vk::ExternalImageFormatProperties::default();
    let mut image_properties = vk::ImageFormatProperties2::default();
    image_properties.next = std::ptr::addr_of_mut!(external_properties).cast();
    match unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &image_format_info,
            &mut image_properties,
        )
    } {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => return Ok(None),
        other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
    }

    let memory_properties = external_properties.external_memory_properties;
    if !memory_properties.compatible_handle_types.contains(handle_type)
        || !memory_properties.external_memory_features.contains(required_features)
    {
        return Ok(None);
    }
    Ok(Some(image_properties.image_format_properties))
}

fn exportable_and_importable() -> vk::ExternalMemoryFeatureFlags {
    vk::ExternalMemoryFeatureFlags::EXPORTABLE | vk::ExternalMemoryFeatureFlags::IMPORTABLE
}

fn color_and_sampled() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED
}

fn not_supported_for_features(format: vk::Format) -> TestError {
    TestError::NotSupported(format!(
        "{format:?} does not support any DRM modifiers for the requested image features"
    ))
}

fn no_tiling_features(format: vk::Format) -> TestError {
    TestError::Fail(format!("{format:?} does not support any DRM modifier tiling features"))
}

/// `listModifiersCase`
fn list_modifiers_case(context: &Context<'_>, format: vk::Format, list2: bool) -> TestOutcome {
    let modifiers = get_drm_format_modifiers(context, format, list2);
    if modifiers.is_empty() {
        return Err(TestError::NotSupported(format!(
            "{format:?} does not support any DRM modifiers"
        )));
    }

    let mut none_compatible = true;
    for props in &modifiers {
        let Some(image_properties) = is_modifier_compatible_with_image_properties(
            context,
            format,
            color_and_sampled(),
            vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
            props.modifier,
            exportable_and_importable(),
        )?
        else {
            continue;
        };
        none_compatible = false;
        if props.tiling_features == 0 {
            return Err(no_tiling_features(format));
        }
        if image_properties.max_extent.width < 1 || image_properties.max_extent.height < 1 {
            return Err(TestError::Fail("maxExtent is smaller than one".to_string()));
        }
        if image_properties.max_array_layers < 1 {
            return Err(TestError::Fail("maxArrayLayers is smaller than one".to_string()));
        }
    }
    if none_compatible {
        return Err(not_supported_for_features(format));
    }
    Ok(TestStatus::pass("OK"))
}

/// `listModifiersConsistency`
fn list_modifiers_consistency(context: &Context<'_>, format: vk::Format) -> TestOutcome {
    let modifiers = get_drm_format_modifiers(context, format, false);
    let modifiers2 = get_drm_format_modifiers(context, format, true);
    if modifiers.len() > modifiers2.len() {
        return Err(TestError::Fail(
            "More modifiers in VkDrmFormatModifierPropertiesListEXT than in VkDrmFormatModifierPropertiesList2EXT"
                .to_string(),
        ));
    }

    let modifiers_by_value: BTreeMap<u64, ModifierProps> =
        modifiers.iter().map(|props| (props.modifier, *props)).collect();
    let modifiers2_by_value: BTreeMap<u64, ModifierProps> =
        modifiers2.iter().map(|props| (props.modifier, *props)).collect();

    let mut fail = false;
    for (modifier, props) in &modifiers_by_value {
        let Some(props2) = modifiers2_by_value.get(modifier) else {
            log::error!("Modifier {modifier} not present in VkDrmFormatModifierPropertiesList2EXT");
            fail = true;
            continue;
        };
        if props.plane_count != props2.plane_count {
            log::error!(
                "Modifier {modifier} has mismatching plane counts: {} vs {}",
                props.plane_count,
                props2.plane_count
            );
            fail = true;
        }
        let features1 = props.tiling_features;
        let features2 = props2.tiling_features & 0x7FFF_FFFF;
        let common_features = features1 & features2;
        if common_features != features1 || common_features != features2 {
            log::error!("Modifier {modifier} has a format features flag mismatch: {features1:#x} vs {features2:#x}");
            fail = true;
        }
    }
    if fail {
        return Err(TestError::Fail(
            "Inconsistent DRM format modifier lists detected; check log for details --".to_string(),
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

fn make_create_info(
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    next: *const std::ffi::c_void,
) -> vk::ImageCreateInfo {
    let mut create_info = vk::ImageCreateInfo::default();
    create_info.next = next;
    create_info.image_type = vk::ImageType::_2D;
    create_info.format = format;
    create_info.extent = vk::Extent3D {
        width: IMAGE_EXTENT,
        height: IMAGE_EXTENT,
        depth: 1,
    };
    create_info.mip_levels = 1;
    create_info.array_layers = 1;
    create_info.samples = vk::SampleCountFlags::_1;
    create_info.tiling = vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT;
    create_info.usage = usage;
    create_info.sharing_mode = vk::SharingMode::EXCLUSIVE;
    create_info.initial_layout = vk::ImageLayout::UNDEFINED;
    create_info
}

/// `createImageWithDrmFormatModifiers`
fn create_image_with_drm_format_modifiers<'a>(
    device: &'a Device,
    usage: vk::ImageUsageFlags,
    handle_type: Option<vk::ExternalMemoryHandleTypeFlags>,
    format: vk::Format,
    modifiers: &[u64],
) -> Result<Unique<'a, vk::Image>, TestError> {
    let mut modifier_list_info = vk::ImageDrmFormatModifierListCreateInfoEXT::default();
    modifier_list_info.drm_format_modifier_count = modifiers.len() as u32;
    modifier_list_info.drm_format_modifiers = modifiers.as_ptr();

    let mut external_memory_info = vk::ExternalMemoryImageCreateInfo::default();
    external_memory_info.next = std::ptr::addr_of!(modifier_list_info).cast();
    external_memory_info.handle_types = handle_type.unwrap_or_default();

    let formats = [format];
    let mut format_list_info = vk::ImageFormatListCreateInfo::default();
    format_list_info.next = if handle_type.is_some() {
        std::ptr::addr_of!(external_memory_info).cast()
    } else {
        std::ptr::addr_of!(modifier_list_info).cast()
    };
    format_list_info.view_format_count = 1;
    format_list_info.view_formats = formats.as_ptr();

    let create_info = make_create_info(format, usage, std::ptr::addr_of!(format_list_info).cast());
    let image = unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}

/// `createImageWithDrmFormatExplicitModifier`
fn create_image_with_drm_format_explicit_modifier<'a>(
    device: &'a Device,
    usage: vk::ImageUsageFlags,
    format: vk::Format,
    modifier: &ModifierProps,
    plane_layouts: &[vk::SubresourceLayout],
) -> Result<Unique<'a, vk::Image>, TestError> {
    let mut explicit_info = vk::ImageDrmFormatModifierExplicitCreateInfoEXT::default();
    explicit_info.drm_format_modifier = modifier.modifier;
    explicit_info.drm_format_modifier_plane_count = modifier.plane_count;
    explicit_info.plane_layouts = plane_layouts.as_ptr();

    let formats = [format];
    let mut format_list_info = vk::ImageFormatListCreateInfo::default();
    format_list_info.next = std::ptr::addr_of!(explicit_info).cast();
    format_list_info.view_format_count = 1;
    format_list_info.view_formats = formats.as_ptr();

    let create_info = make_create_info(format, usage, std::ptr::addr_of!(format_list_info).cast());
    let image = unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}

fn drm_format_modifier_of(device: &Device, image: vk::Image) -> Result<u64, TestError> {
    let mut properties = vk::ImageDrmFormatModifierPropertiesEXT::default();
    unsafe { device.get_image_drm_format_modifier_properties_ext(image, &mut properties) }
        .vk_check("vkGetImageDrmFormatModifierPropertiesEXT")?;
    Ok(properties.drm_format_modifier)
}

/// `createImageListModifiersCase`
fn create_image_list_modifiers_case(context: &Context<'_>, format: vk::Format, list2: bool) -> TestOutcome {
    let device = context.get_device();
    let drm_modifiers = get_drm_format_modifiers(context, format, list2);
    if drm_modifiers.is_empty() {
        return Err(TestError::NotSupported(format!(
            "{format:?} does not support any DRM modifiers"
        )));
    }

    let mut modifiers = Vec::new();
    for props in &drm_modifiers {
        let compatible = is_modifier_compatible_with_image_properties(
            context,
            format,
            color_and_sampled(),
            vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
            props.modifier,
            exportable_and_importable(),
        )?;
        if compatible.is_some() {
            modifiers.push(props.modifier);
        }
        if props.tiling_features == 0 {
            return Err(no_tiling_features(format));
        }
    }
    if modifiers.is_empty() {
        return Err(not_supported_for_features(format));
    }

    for len in 1..=modifiers.len() {
        let creation_modifiers = &modifiers[..len];
        let modifier = {
            let image =
                create_image_with_drm_format_modifiers(device, color_and_sampled(), None, format, creation_modifiers)?;
            drm_format_modifier_of(device, *image)?
        };
        if !creation_modifiers.contains(&modifier) {
            return Ok(TestStatus::fail(
                "Image created with modifier not specified in the create list",
            ));
        }
    }
    Ok(TestStatus::pass("OK"))
}

/// `createAndBoundImageToDmaBufCase`
fn create_and_bound_image_to_dma_buf_case(context: &Context<'_>, format: vk::Format) -> TestOutcome {
    let device = context.get_device();
    let handle_type = vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT;
    let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let drm_modifiers = get_drm_format_modifiers(context, format, false);
    if drm_modifiers.is_empty() {
        return Err(TestError::NotSupported(format!(
            "{format:?} does not support any DRM modifiers"
        )));
    }

    let mut modifiers = Vec::new();
    for props in &drm_modifiers {
        let compatible = is_modifier_compatible_with_image_properties(
            context,
            format,
            usage,
            handle_type,
            props.modifier,
            vk::ExternalMemoryFeatureFlags::EXPORTABLE,
        )?;
        if compatible.is_some() {
            modifiers.push(props.modifier);
        }
        if props.tiling_features == 0 {
            return Err(no_tiling_features(format));
        }
    }
    if modifiers.is_empty() {
        return Err(not_supported_for_features(format));
    }

    for len in 1..=modifiers.len() {
        let image =
            create_image_with_drm_format_modifiers(device, usage, Some(handle_type), format, &modifiers[..len])?;
        drm_format_modifier_of(device, *image)?;
        let requirements = unsafe { device.get_image_memory_requirements(*image) };
        let memory_type_index = choose_memory_type(requirements.memory_type_bits);
        let memory = allocate_exportable_memory(
            device,
            requirements.size,
            memory_type_index,
            handle_type,
            DedicatedTo::Image(*image),
        )?;
        unsafe { device.bind_image_memory(*image, *memory, 0) }.vk_check("vkBindImageMemory")?;
        let _handle = get_memory_native(device, *memory, handle_type)?;
    }
    Ok(TestStatus::pass("OK"))
}

/// `createImageModifierExplicitCase`
fn create_image_modifier_explicit_case(context: &Context<'_>, format: vk::Format, list2: bool) -> TestOutcome {
    let device = context.get_device();
    let drm_modifiers = get_drm_format_modifiers(context, format, list2);
    if drm_modifiers.is_empty() {
        return Err(TestError::NotSupported(format!(
            "{format:?} does not support any DRM modifiers"
        )));
    }

    let mut modifiers = Vec::new();
    for props in &drm_modifiers {
        if props.tiling_features == 0 {
            return Err(no_tiling_features(format));
        }
        let compatible = is_modifier_compatible_with_image_properties(
            context,
            format,
            color_and_sampled(),
            vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
            props.modifier,
            exportable_and_importable(),
        )?;
        if compatible.is_some() {
            modifiers.push(*props);
        }
    }
    if modifiers.is_empty() {
        return Err(not_supported_for_features(format));
    }

    for modifier in &modifiers {
        let image_ref =
            create_image_with_drm_format_modifiers(device, color_and_sampled(), None, format, &[modifier.modifier])?;

        let mut plane_layouts = Vec::new();
        for plane in 0..modifier.plane_count {
            let image_subresource = vk::ImageSubresource {
                aspect_mask: vk::ImageAspectFlags::from_bits_truncate(
                    vk::ImageAspectFlags::MEMORY_PLANE_0_EXT.bits() << plane,
                ),
                mip_level: 0,
                array_layer: 0,
            };
            let mut subresource_layout = unsafe { device.get_image_subresource_layout(*image_ref, &image_subresource) };
            // VUID-VkImageDrmFormatModifierExplicitCreateInfoEXT-size-02267, -arrayPitch-02268 and -depthPitch-02269
            subresource_layout.size = 0;
            subresource_layout.array_pitch = 0;
            subresource_layout.depth_pitch = 0;
            plane_layouts.push(subresource_layout);
        }

        let image = create_image_with_drm_format_explicit_modifier(
            device,
            color_and_sampled(),
            format,
            modifier,
            &plane_layouts,
        )?;
        if drm_format_modifier_of(device, *image)? != modifier.modifier {
            return Ok(TestStatus::fail(
                "The created image's modifier with an explicit modifier not matched",
            ));
        }
    }
    Ok(TestStatus::pass("OK"))
}

/// `verifyHandleTypeForFormatModifier`
fn verify_handle_type_for_format_modifier(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    modifier: u64,
    require_non_dedicated: bool,
) -> Result<bool, TestError> {
    let mut modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT::default();
    modifier_info.drm_format_modifier = modifier;
    modifier_info.sharing_mode = vk::SharingMode::EXCLUSIVE;

    let mut external_info = vk::PhysicalDeviceExternalImageFormatInfo::default();
    external_info.next = std::ptr::addr_of!(modifier_info).cast();
    external_info.handle_type = handle_type;

    let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2::default();
    image_format_info.next = std::ptr::addr_of!(external_info).cast();
    image_format_info.format = format;
    image_format_info.type_ = vk::ImageType::_2D;
    image_format_info.tiling = vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT;
    image_format_info.usage = usage;

    let mut external_properties = vk::ExternalImageFormatProperties::default();
    let mut image_properties = vk::ImageFormatProperties2::default();
    image_properties.next = std::ptr::addr_of_mut!(external_properties).cast();
    match unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &image_format_info,
            &mut image_properties,
        )
    } {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => return Ok(false),
        other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
    }

    let memory_properties = external_properties.external_memory_properties;
    if !memory_properties.compatible_handle_types.contains(handle_type)
        || !memory_properties
            .external_memory_features
            .contains(exportable_and_importable())
    {
        return Ok(false);
    }
    if require_non_dedicated
        && memory_properties
            .external_memory_features
            .contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY)
    {
        return Ok(false);
    }
    Ok(true)
}

/// `getExportImportCompatibleModifiers`
fn get_export_import_compatible_modifiers(
    context: &Context<'_>,
    format: vk::Format,
    list2: bool,
) -> Result<Vec<ModifierProps>, TestError> {
    let modifiers = get_drm_format_modifiers(context, format, list2);
    let mut compatible = Vec::new();
    let test_features = u64::from(
        (vk::FormatFeatureFlags::TRANSFER_SRC
            | vk::FormatFeatureFlags::BLIT_SRC
            | vk::FormatFeatureFlags::BLIT_DST
            | vk::FormatFeatureFlags::TRANSFER_DST)
            .bits(),
    );
    for props in modifiers {
        if props.tiling_features == 0 {
            return Err(no_tiling_features(format));
        }
        if props.tiling_features & test_features != test_features {
            continue;
        }
        if !verify_handle_type_for_format_modifier(
            context,
            format,
            color_and_sampled(),
            vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
            props.modifier,
            false,
        )? {
            continue;
        }
        compatible.push(props);
    }
    Ok(compatible)
}

/// `createImageNoModifiers`
fn create_image_no_modifiers<'a>(
    device: &'a Device,
    usage: vk::ImageUsageFlags,
    format: vk::Format,
) -> Result<Unique<'a, vk::Image>, TestError> {
    let mut create_info = make_create_info(format, usage, std::ptr::null());
    create_info.tiling = vk::ImageTiling::OPTIMAL;
    create_info.initial_layout = vk::ImageLayout::PREINITIALIZED;
    let image = unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}

/// The plain `vkAllocateMemory` of the test: the lowest memory type the image allows, bound at offset 0
fn allocate_and_bind_image_memory<'a>(
    device: &'a Device,
    image: vk::Image,
) -> Result<Unique<'a, vk::DeviceMemory>, TestError> {
    let requirements = unsafe { device.get_image_memory_requirements(image) };
    let info = vk::MemoryAllocateInfo::builder()
        .allocation_size(requirements.size)
        .memory_type_index(choose_memory_type(requirements.memory_type_bits));
    let memory = Unique::new(
        device,
        unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?,
    );
    unsafe { device.bind_image_memory(image, *memory, 0) }.vk_check("vkBindImageMemory")?;
    Ok(memory)
}

fn plane_layouts_of(device: &Device, image: vk::Image, plane_count: u32) -> Vec<vk::SubresourceLayout> {
    let mut plane_layouts = Vec::new();
    for plane in 0..plane_count {
        let image_subresource = vk::ImageSubresource {
            aspect_mask: vk::ImageAspectFlags::from_bits_truncate(
                vk::ImageAspectFlags::MEMORY_PLANE_0_EXT.bits() << plane,
            ),
            mip_level: 0,
            array_layer: 0,
        };
        let mut subresource_layout = unsafe { device.get_image_subresource_layout(image, &image_subresource) };
        subresource_layout.size = 0;
        subresource_layout.array_pitch = 0;
        subresource_layout.depth_pitch = 0;
        plane_layouts.push(subresource_layout);
    }
    plane_layouts
}

fn transfer_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `exportImportMemoryExplicitModifiersCase` (the per-modifier function): true when the imported image reads back as written
fn export_import_memory_explicit_modifiers_case(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    format: vk::Format,
    modifier: &ModifierProps,
) -> Result<bool, TestError> {
    let device = context.get_device();
    let handle_type = vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD;
    let transfer_usage = vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;

    if !verify_handle_type_for_format_modifier(
        context,
        format,
        color_and_sampled(),
        handle_type,
        modifier.modifier,
        false,
    )? {
        return Err(TestError::Fail(format!(
            "Modifier {} for format {format:?} expected to be compatible",
            modifier.modifier
        )));
    }

    let modifiers = [modifier.modifier];
    let reference_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("the texture format of {format:?}")))?;
    let pixel_size = reference_format
        .pixel_size()
        .ok_or_else(|| TestError::NotPorted(format!("the pixel size of {format:?}")))? as usize;
    let image_bytes = (IMAGE_EXTENT * IMAGE_EXTENT) as usize * pixel_size;
    let buffer_size: vk::DeviceSize = 1 << 16;

    let input_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let output_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let cmd_pool = make_command_pool(device, queue_family_index)?;

    let format_info = get_texture_format_info(reference_format);
    {
        let input_bytes =
            unsafe { std::slice::from_raw_parts_mut(input_buffer.get_allocation().get_host_ptr(), image_bytes) };
        let mut reference_image =
            PixelBufferAccess::new(reference_format, [IMAGE_EXTENT, IMAGE_EXTENT, 1], input_bytes);
        // `fillWithComponentGradients` and `...2` agree for a two dimensional access
        fill_with_component_gradients2(&mut reference_image, format_info.value_min, format_info.value_max);
    }
    flush_alloc(device, input_buffer.get_allocation())?;

    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let extent = vk::Extent3D {
        width: IMAGE_EXTENT,
        height: IMAGE_EXTENT,
        depth: 1,
    };

    let src_image = create_image_no_modifiers(device, transfer_usage, format)?;
    let _src_memory = allocate_and_bind_image_memory(device, *src_image)?;

    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;
    transfer_barrier(
        device,
        *cmd_buffer,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *src_image,
            color_range,
        ),
    );
    let region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    unsafe {
        device.cmd_copy_buffer_to_image(
            *cmd_buffer,
            *input_buffer,
            *src_image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[region],
        );
    }

    let dst_image =
        create_image_with_drm_format_modifiers(device, transfer_usage, Some(handle_type), format, &modifiers)?;
    let dst_requirements = unsafe { device.get_image_memory_requirements(*dst_image) };
    let dst_memory = allocate_exportable_memory(
        device,
        dst_requirements.size,
        choose_memory_type(dst_requirements.memory_type_bits),
        handle_type,
        DedicatedTo::Image(*dst_image),
    )?;
    unsafe { device.bind_image_memory(*dst_image, *dst_memory, 0) }.vk_check("vkBindImageMemory")?;

    transfer_barrier(
        device,
        *cmd_buffer,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *src_image,
            color_range,
        ),
    );
    transfer_barrier(
        device,
        *cmd_buffer,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_READ,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *dst_image,
            color_range,
        ),
    );
    let image_copy = vk::ImageCopy {
        src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        extent,
    };
    unsafe {
        device.cmd_copy_image(
            *cmd_buffer,
            *src_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *dst_image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[image_copy],
        );
    }
    let mut export_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        *dst_image,
        color_range,
    );
    export_barrier.src_queue_family_index = queue_family_index;
    export_barrier.dst_queue_family_index = vk::QUEUE_FAMILY_FOREIGN_EXT;
    transfer_barrier(device, *cmd_buffer, vk::PipelineStageFlags::TRANSFER, export_barrier);
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, queue, *cmd_buffer)?;

    if drm_format_modifier_of(device, *dst_image)? != modifiers[0] {
        return Err(TestError::Fail(
            "The exported image has another modifier than requested".to_string(),
        ));
    }
    let mut input_image_mem_fd = get_memory_native(device, *dst_memory, handle_type)?;

    let plane_layouts = plane_layouts_of(device, *dst_image, modifier.plane_count);
    let imported_src_image = {
        let mut explicit_info = vk::ImageDrmFormatModifierExplicitCreateInfoEXT::default();
        explicit_info.drm_format_modifier = modifier.modifier;
        explicit_info.drm_format_modifier_plane_count = modifier.plane_count;
        explicit_info.plane_layouts = plane_layouts.as_ptr();

        let mut external_memory_info = vk::ExternalMemoryImageCreateInfo::default();
        external_memory_info.next = std::ptr::addr_of!(explicit_info).cast();
        external_memory_info.handle_types = handle_type;

        let formats = [format];
        let mut format_list_info = vk::ImageFormatListCreateInfo::default();
        format_list_info.next = std::ptr::addr_of!(external_memory_info).cast();
        format_list_info.view_format_count = 1;
        format_list_info.view_formats = formats.as_ptr();

        let create_info = make_create_info(format, transfer_usage, std::ptr::addr_of!(format_list_info).cast());
        Unique::new(
            device,
            unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
        )
    };
    let imported_requirements = unsafe { device.get_image_memory_requirements(*imported_src_image) };
    let imported_memory = import_memory(
        device,
        &imported_requirements,
        handle_type,
        u32::MAX,
        &mut input_image_mem_fd,
        DedicatedTo::Image(*imported_src_image),
    )?;
    unsafe { device.bind_image_memory(*imported_src_image, *imported_memory, 0) }.vk_check("vkBindImageMemory")?;

    let out_image = create_image_no_modifiers(device, transfer_usage, format)?;
    let _out_memory = allocate_and_bind_image_memory(device, *out_image)?;

    let cmd_buffer2 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer2)?;
    let mut imported_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        *imported_src_image,
        color_range,
    );
    imported_barrier.src_queue_family_index = vk::QUEUE_FAMILY_FOREIGN_EXT;
    imported_barrier.dst_queue_family_index = queue_family_index;
    transfer_barrier(device, *cmd_buffer2, vk::PipelineStageFlags::TRANSFER, imported_barrier);
    transfer_barrier(
        device,
        *cmd_buffer2,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_READ,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *out_image,
            color_range,
        ),
    );
    unsafe {
        device.cmd_copy_image(
            *cmd_buffer2,
            *imported_src_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *out_image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[image_copy],
        );
    }
    transfer_barrier(
        device,
        *cmd_buffer2,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *out_image,
            color_range,
        ),
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            *cmd_buffer2,
            *out_image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *output_buffer,
            &[region],
        );
        let host_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(*output_buffer)
            .offset(0)
            .size(vk::WHOLE_SIZE);
        device.cmd_pipeline_barrier(
            *cmd_buffer2,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[host_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, *cmd_buffer2)?;
    submit_commands_and_wait(device, queue, *cmd_buffer2)?;

    invalidate_alloc(device, output_buffer.get_allocation())?;
    let reference = unsafe { std::slice::from_raw_parts(input_buffer.get_allocation().get_host_ptr(), image_bytes) };
    let result = unsafe { std::slice::from_raw_parts(output_buffer.get_allocation().get_host_ptr(), image_bytes) };
    let size = [IMAGE_EXTENT, IMAGE_EXTENT, 1];
    let comparison = int_threshold_compare(
        &ConstPixelBufferAccess::new(reference_format, size, reference),
        &ConstPixelBufferAccess::new(reference_format, size, result),
        UVec4::from_array([0; 4]),
    );
    Ok(comparison.ok)
}

/// `verifyRequiresDedicatedAllocation`
fn requires_dedicated_allocation(device: &Device, image: vk::Image) -> bool {
    let info = vk::ImageMemoryRequirementsInfo2::builder().image(image);
    let mut dedicated = vk::MemoryDedicatedRequirements::default();
    {
        let mut requirements = vk::MemoryRequirements2::builder().push_next(&mut dedicated);
        unsafe { device.get_image_memory_requirements2(&info, &mut requirements) };
    }
    dedicated.requires_dedicated_allocation != vk::FALSE
}

fn align_up(value: vk::DeviceSize, alignment: vk::DeviceSize) -> vk::DeviceSize {
    (value + alignment - 1) & !(alignment - 1)
}

/// The image `createImageWithDrmFormatExplicitModifier` makes for an exported one, over an already built plane layout list
fn create_imported_image<'a>(
    device: &'a Device,
    format: vk::Format,
    modifier: &ModifierProps,
    plane_layouts: &[vk::SubresourceLayout],
) -> Result<Unique<'a, vk::Image>, TestError> {
    let mut explicit_info = vk::ImageDrmFormatModifierExplicitCreateInfoEXT::default();
    explicit_info.drm_format_modifier = modifier.modifier;
    explicit_info.drm_format_modifier_plane_count = modifier.plane_count;
    explicit_info.plane_layouts = plane_layouts.as_ptr();

    let mut external_memory_info = vk::ExternalMemoryImageCreateInfo::default();
    external_memory_info.next = std::ptr::addr_of!(explicit_info).cast();
    external_memory_info.handle_types = vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD;

    let formats = [format];
    let mut format_list_info = vk::ImageFormatListCreateInfo::default();
    format_list_info.next = std::ptr::addr_of!(external_memory_info).cast();
    format_list_info.view_format_count = 1;
    format_list_info.view_formats = formats.as_ptr();

    let create_info = make_create_info(
        format,
        vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
        std::ptr::addr_of!(format_list_info).cast(),
    );
    Ok(Unique::new(
        device,
        unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
    ))
}

/// `exportImportMemoryExplicitModifiersWithSuballocationCase` (the per-modifier function). Upstream's two quirks are kept: the suballocated result is read
/// from the same buffer as the prime one, and the two output images share offset 0 of their memory.
fn export_import_with_suballocation_modifier_case(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    format: vk::Format,
    modifier: &ModifierProps,
) -> Result<bool, TestError> {
    let device = context.get_device();
    let handle_type = vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD;
    let transfer_usage = vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC;

    if !verify_handle_type_for_format_modifier(
        context,
        format,
        color_and_sampled(),
        handle_type,
        modifier.modifier,
        true,
    )? {
        return Err(TestError::NotSupported("require dedicated memory".to_string()));
    }

    let modifiers = [modifier.modifier];
    let reference_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("the texture format of {format:?}")))?;
    let pixel_size = reference_format
        .pixel_size()
        .ok_or_else(|| TestError::NotPorted(format!("the pixel size of {format:?}")))? as usize;
    let image_bytes = (IMAGE_EXTENT * IMAGE_EXTENT) as usize * pixel_size;
    let buffer_size: vk::DeviceSize = 1 << 16;

    let input_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let output_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let output_sub_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let cmd_pool = make_command_pool(device, queue_family_index)?;

    let format_info = get_texture_format_info(reference_format);
    {
        let input_bytes =
            unsafe { std::slice::from_raw_parts_mut(input_buffer.get_allocation().get_host_ptr(), image_bytes) };
        let mut reference_image =
            PixelBufferAccess::new(reference_format, [IMAGE_EXTENT, IMAGE_EXTENT, 1], input_bytes);
        fill_with_component_gradients2(&mut reference_image, format_info.value_min, format_info.value_max);
    }
    flush_alloc(device, input_buffer.get_allocation())?;

    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let extent = vk::Extent3D {
        width: IMAGE_EXTENT,
        height: IMAGE_EXTENT,
        depth: 1,
    };
    let layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let region = make_buffer_image_copy(extent, layers);
    let image_copy = vk::ImageCopy {
        src_subresource: layers,
        src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        dst_subresource: layers,
        dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        extent,
    };

    let src_image = create_image_no_modifiers(device, transfer_usage, format)?;
    let _src_memory = allocate_and_bind_image_memory(device, *src_image)?;

    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;
    transfer_barrier(
        device,
        *cmd_buffer,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *src_image,
            color_range,
        ),
    );
    unsafe {
        device.cmd_copy_buffer_to_image(
            *cmd_buffer,
            *input_buffer,
            *src_image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &[region],
        );
    }

    let dst_image =
        create_image_with_drm_format_modifiers(device, transfer_usage, Some(handle_type), format, &modifiers)?;
    let dst_sub_image =
        create_image_with_drm_format_modifiers(device, transfer_usage, Some(handle_type), format, &modifiers)?;
    if requires_dedicated_allocation(device, *dst_image) || requires_dedicated_allocation(device, *dst_sub_image) {
        return Err(TestError::NotSupported("requires dedicated allocation".to_string()));
    }

    let dst_image_requirements = unsafe { device.get_image_memory_requirements(*dst_image) };
    let dst_sub_image_requirements = unsafe { device.get_image_memory_requirements(*dst_sub_image) };
    let aligned_dst_image_size = align_up(dst_image_requirements.size, dst_image_requirements.alignment);
    let aligned_dst_sub_image_size = align_up(dst_sub_image_requirements.size, dst_sub_image_requirements.alignment);
    let memory_type_index =
        choose_memory_type(dst_image_requirements.memory_type_bits & dst_sub_image_requirements.memory_type_bits);
    let mut export_info = vk::ExportMemoryAllocateInfo::builder().handle_types(handle_type);
    let allocate_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(aligned_dst_image_size + aligned_dst_sub_image_size)
        .memory_type_index(memory_type_index)
        .push_next(&mut export_info);
    let dst_memory = Unique::new(
        device,
        unsafe { device.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?,
    );
    unsafe { device.bind_image_memory(*dst_image, *dst_memory, 0) }.vk_check("vkBindImageMemory")?;
    unsafe { device.bind_image_memory(*dst_sub_image, *dst_memory, aligned_dst_image_size) }
        .vk_check("vkBindImageMemory")?;

    transfer_barrier(
        device,
        *cmd_buffer,
        vk::PipelineStageFlags::TRANSFER,
        make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            *src_image,
            color_range,
        ),
    );
    for image in [&dst_image, &dst_sub_image] {
        transfer_barrier(
            device,
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                **image,
                color_range,
            ),
        );
    }
    for image in [&dst_image, &dst_sub_image] {
        unsafe {
            device.cmd_copy_image(
                *cmd_buffer,
                *src_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                **image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[image_copy],
            );
        }
    }
    for image in [&dst_image, &dst_sub_image] {
        let mut export_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            **image,
            color_range,
        );
        export_barrier.src_queue_family_index = queue_family_index;
        export_barrier.dst_queue_family_index = vk::QUEUE_FAMILY_FOREIGN_EXT;
        transfer_barrier(device, *cmd_buffer, vk::PipelineStageFlags::TRANSFER, export_barrier);
    }
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, queue, *cmd_buffer)?;

    // Upstream queries the prime image twice, the second time for the suballocated one
    if drm_format_modifier_of(device, *dst_image)? != modifiers[0] {
        return Err(TestError::Fail(
            "The exported image has another modifier than requested".to_string(),
        ));
    }
    let mut input_image_mem_fd = get_memory_native(device, *dst_memory, handle_type)?;

    let plane_layouts = plane_layouts_of(device, *dst_image, modifier.plane_count);
    let imported_src_image = create_imported_image(device, format, modifier, &plane_layouts)?;
    let imported_src_sub_image = create_imported_image(device, format, modifier, &plane_layouts)?;
    let imported_single_requirements = unsafe { device.get_image_memory_requirements(*imported_src_image) };
    let aligned_single_image_size = align_up(
        imported_single_requirements.size,
        imported_single_requirements.alignment,
    );
    let mut imported_requirements = imported_single_requirements;
    imported_requirements.size = aligned_single_image_size * 2;
    let imported_memory = import_memory(
        device,
        &imported_requirements,
        handle_type,
        u32::MAX,
        &mut input_image_mem_fd,
        DedicatedTo::None,
    )?;
    unsafe { device.bind_image_memory(*imported_src_image, *imported_memory, 0) }.vk_check("vkBindImageMemory")?;
    unsafe { device.bind_image_memory(*imported_src_sub_image, *imported_memory, aligned_single_image_size) }
        .vk_check("vkBindImageMemory")?;

    let out_image = create_image_no_modifiers(device, transfer_usage, format)?;
    let out_sub_image = create_image_no_modifiers(device, transfer_usage, format)?;
    let out_requirements = unsafe { device.get_image_memory_requirements(*out_image) };
    let out_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(out_requirements.size * 2)
        .memory_type_index(choose_memory_type(out_requirements.memory_type_bits));
    let out_memory = Unique::new(
        device,
        unsafe { device.allocate_memory(&out_info, None) }.vk_check("vkAllocateMemory")?,
    );
    unsafe { device.bind_image_memory(*out_image, *out_memory, 0) }.vk_check("vkBindImageMemory")?;
    unsafe { device.bind_image_memory(*out_sub_image, *out_memory, 0) }.vk_check("vkBindImageMemory")?;

    let cmd_buffer2 = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer2)?;
    for image in [&imported_src_image, &imported_src_sub_image] {
        let mut imported_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            **image,
            color_range,
        );
        imported_barrier.src_queue_family_index = vk::QUEUE_FAMILY_FOREIGN_EXT;
        imported_barrier.dst_queue_family_index = queue_family_index;
        transfer_barrier(device, *cmd_buffer2, vk::PipelineStageFlags::TRANSFER, imported_barrier);
    }
    for image in [&out_image, &out_sub_image] {
        transfer_barrier(
            device,
            *cmd_buffer2,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                **image,
                color_range,
            ),
        );
    }
    for (imported, out) in [
        (&imported_src_image, &out_image),
        (&imported_src_sub_image, &out_sub_image),
    ] {
        unsafe {
            device.cmd_copy_image(
                *cmd_buffer2,
                **imported,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                **out,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[image_copy],
            );
        }
    }
    for (out, buffer) in [(&out_image, &output_buffer), (&out_sub_image, &output_sub_buffer)] {
        transfer_barrier(
            device,
            *cmd_buffer2,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                **out,
                color_range,
            ),
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                *cmd_buffer2,
                **out,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                **buffer,
                &[region],
            );
            let host_barrier = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(**buffer)
                .offset(0)
                .size(vk::WHOLE_SIZE);
            device.cmd_pipeline_barrier(
                *cmd_buffer2,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(device, *cmd_buffer2)?;
    submit_commands_and_wait(device, queue, *cmd_buffer2)?;

    invalidate_alloc(device, output_buffer.get_allocation())?;
    let reference = unsafe { std::slice::from_raw_parts(input_buffer.get_allocation().get_host_ptr(), image_bytes) };
    let result = unsafe { std::slice::from_raw_parts(output_buffer.get_allocation().get_host_ptr(), image_bytes) };
    let size = [IMAGE_EXTENT, IMAGE_EXTENT, 1];
    let compare = || {
        int_threshold_compare(
            &ConstPixelBufferAccess::new(reference_format, size, reference),
            &ConstPixelBufferAccess::new(reference_format, size, result),
            UVec4::from_array([0; 4]),
        )
        .ok
    };
    let prime_result = compare();
    let sub_result = compare();
    Ok(prime_result && sub_result)
}

/// `exportImportMemoryExplicitModifiersWithSuballocationCase` (the case function)
fn export_import_with_suballocation_case(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    format: vk::Format,
    list2: bool,
) -> TestOutcome {
    let compatible_modifiers = get_export_import_compatible_modifiers(context, format, list2)?;
    if compatible_modifiers.is_empty() {
        return Err(TestError::Fail(
            "Expected non-empty list of compatible modifiers for the given format".to_string(),
        ));
    }
    let mut none_supported = true;
    let mut fail = false;
    for modifier in &compatible_modifiers {
        match export_import_with_suballocation_modifier_case(context, queue, queue_family_index, format, modifier) {
            Ok(true) => none_supported = false,
            Ok(false) => {
                log::error!("Modifier {} failed: unexpected copy image result", modifier.modifier);
                fail = true;
                none_supported = false;
            }
            Err(TestError::NotSupported(message)) => {
                log::info!("Modifier {} not supported: {message}", modifier.modifier);
            }
            Err(error) => return Err(error),
        }
    }
    if none_supported {
        return Err(TestError::NotSupported(format!(
            "None of DRM modifiers for {format:?} can be used in a suballocated image; check log for details"
        )));
    }
    if fail {
        return Err(TestError::Fail(
            "Unexpected copy image results; check log for details".to_string(),
        ));
    }
    Ok(TestStatus::pass("OK; check log for details"))
}

/// `exportImportMemoryExplicitModifiersCase` (the case function), over every compatible modifier on one queue
fn export_import_case(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    format: vk::Format,
    list2: bool,
) -> TestOutcome {
    let compatible_modifiers = get_export_import_compatible_modifiers(context, format, list2)?;
    if compatible_modifiers.is_empty() {
        return Err(TestError::Fail(
            "Expected non-empty list of compatible modifiers for the given format".to_string(),
        ));
    }
    for modifier in &compatible_modifiers {
        if !export_import_memory_explicit_modifiers_case(context, queue, queue_family_index, format, modifier)? {
            return Ok(TestStatus::fail("Unexpected copy image result"));
        }
    }
    Ok(TestStatus::pass("OK"))
}

/// `checkExportImportExtensions`
fn check_export_import_extensions(context: &Context<'_>, format: vk::Format, list2: bool) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_external_memory_fd")?;
    if list2 {
        check_modifiers_list2_supported(context, format)?;
    } else {
        check_modifiers_supported(context, format)?;
    }
    if get_export_import_compatible_modifiers(context, format, list2)?.is_empty() {
        return Err(TestError::NotSupported(format!(
            "Could not find a format modifier supporting required transfer features for {format:?}"
        )));
    }
    Ok(())
}

struct DrmModifierCase {
    name: String,
    family: Family,
    format: vk::Format,
}

impl TestCase for DrmModifierCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.family.is_export_import() {
            return check_export_import_extensions(context, self.format, self.family.uses_list2());
        }
        if self.family.uses_list2() {
            check_modifiers_list2_supported(context, self.format)
        } else {
            check_modifiers_supported(context, self.format)
        }
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DrmModifierInstance {
            context,
            family: self.family,
            format: self.format,
        })
    }
}

struct DrmModifierInstance<'a> {
    context: &'a Context<'a>,
    family: Family,
    format: vk::Format,
}

impl TestInstance for DrmModifierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let (context, format) = (self.context, self.format);
        match self.family {
            Family::ListModifiers => list_modifiers_case(context, format, false),
            Family::ListModifiersFmtFeatures2 => list_modifiers_case(context, format, true),
            Family::Consistency => list_modifiers_consistency(context, format),
            Family::CreateList => create_image_list_modifiers_case(context, format, false),
            Family::CreateListFmtFeatures2 => create_image_list_modifiers_case(context, format, true),
            Family::BoundToDmaBuf => create_and_bound_image_to_dma_buf_case(context, format),
            Family::CreateExplicit => create_image_modifier_explicit_case(context, format, false),
            Family::CreateExplicitFmtFeatures2 => create_image_modifier_explicit_case(context, format, true),
            Family::ExportImport | Family::ExportImportFmtFeatures2 => {
                let list2 = self.family.uses_list2();
                run_on_queues(queues_for(context, true), |queue, queue_family_index| {
                    export_import_case(context, queue, queue_family_index, format, list2)
                })
            }
            Family::ExportImportWithSuballoc | Family::ExportImportFmtFeatures2WithSuballoc => {
                let list2 = self.family.uses_list2();
                run_on_queues(queues_for(context, true), |queue, queue_family_index| {
                    export_import_with_suballocation_case(context, queue, queue_family_index, format, list2)
                })
            }
        }
    }
}

const FAMILIES: [(&str, Family); 12] = [
    ("list_modifiers", Family::ListModifiers),
    ("list_modifiers_fmt_features2", Family::ListModifiersFmtFeatures2),
    ("list_modifiers_consistency", Family::Consistency),
    ("create_list_modifiers", Family::CreateList),
    ("create_list_modifiers_fmt_features2", Family::CreateListFmtFeatures2),
    ("bound_to_dma_buf", Family::BoundToDmaBuf),
    ("create_explicit_modifier", Family::CreateExplicit),
    (
        "create_explicit_modifier_fmt_features2",
        Family::CreateExplicitFmtFeatures2,
    ),
    ("export_import", Family::ExportImport),
    ("export_import_fmt_features2", Family::ExportImportFmtFeatures2),
    ("export_import_with_suballoc", Family::ExportImportWithSuballoc),
    (
        "export_import_fmt_features2_with_suballoc",
        Family::ExportImportFmtFeatures2WithSuballoc,
    ),
];

/// `modifiers::createTests` - the `drm_format_modifiers` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("drm_format_modifiers");
    for (family_name, family) in FAMILIES {
        let mut family_group = TestCaseGroup::new(family_name);
        for &format in BASIC_COLOR_FORMATS {
            family_group.add_child(Box::new(DrmModifierCase {
                name: short_format_name(format),
                family,
                format,
            }) as Box<dyn TestCase>);
        }
        group.add_child(family_group);
    }
    group
}
