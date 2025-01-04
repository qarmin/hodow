// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageTilingControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. vulkanalia has no bindings for VK_EXT_image_tiling_control,
// so its two structures are declared below with the sType values from vk.xml; `vkGetDeviceImageSubresourceLayout` is the
// KHR (maintenance5) entry point as in `subresource_layout_tests.rs`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_1, DeviceV1_3, InstanceV1_1, KhrMaintenance4ExtensionDeviceCommands,
    KhrMaintenance5ExtensionDeviceCommands,
};

use crate::tcu::texture::{ChannelOrder, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::sparse_resources::tests_util::get_image_size_alignment;
use crate::vkt::tests::ycbcr::copy_tests::{is_ycbcr_format, planes_of};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_TILING_CONTROL_FEATURES_EXT: i32 = 1_000_687_000;
const STRUCTURE_TYPE_IMAGE_TILING_CONTROL_CREATE_INFO_EXT: i32 = 1_000_687_001;

/// `VkPhysicalDeviceImageTilingControlFeaturesEXT`
#[repr(C)]
struct ImageTilingControlFeaturesExt {
    s_type: vk::StructureType,
    next: *mut c_void,
    image_tiling_control: vk::Bool32,
}

/// `VkImageTilingControlCreateInfoEXT`
#[repr(C)]
#[derive(Clone, Copy)]
struct ImageTilingControlCreateInfoExt {
    s_type: vk::StructureType,
    next: *const c_void,
    tiling_control: i32,
}

impl ImageTilingControlCreateInfoExt {
    fn new() -> Self {
        Self {
            s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_IMAGE_TILING_CONTROL_CREATE_INFO_EXT),
            next: std::ptr::null(),
            tiling_control: 0,
        }
    }
}

/// The tiling control variant a test case exercises. `Unspecified` chains no `VkImageTilingControlCreateInfoEXT` at all.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TilingMode {
    Unspecified = 0,
    Default,
    MinSize,
    MaxPerformance,
}

const MODES: [TilingMode; 4] = [
    TilingMode::Unspecified,
    TilingMode::Default,
    TilingMode::MinSize,
    TilingMode::MaxPerformance,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TilingScheme {
    Optimal,
    DrmModifier,
}

fn get_vk_tiling(scheme: TilingScheme) -> vk::ImageTiling {
    if scheme == TilingScheme::DrmModifier {
        vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT
    } else {
        vk::ImageTiling::OPTIMAL
    }
}

fn get_tiling_mode_name(mode: TilingMode) -> &'static str {
    match mode {
        TilingMode::Unspecified => "unspecified",
        TilingMode::Default => "default",
        TilingMode::MinSize => "min_space",
        TilingMode::MaxPerformance => "max_performance",
    }
}

/// `getTilingControlValue`
fn get_tiling_control_value(mode: TilingMode) -> i32 {
    match mode {
        TilingMode::MinSize => 1,
        TilingMode::MaxPerformance => 2,
        TilingMode::Default | TilingMode::Unspecified => 0,
    }
}

fn plane_count(format: vk::Format) -> usize {
    planes_of(format).len().max(1)
}

/// `getSubresourceAspect`
fn get_subresource_aspect(format: vk::Format, tiling_scheme: TilingScheme) -> Result<vk::ImageAspectFlags, TestError> {
    // For DRM-modifier images the query addresses memory planes, not color or depth/stencil aspects.
    if tiling_scheme == TilingScheme::DrmModifier {
        return Ok(vk::ImageAspectFlags::MEMORY_PLANE_0_EXT);
    }

    if is_ycbcr_format(format) {
        return Ok(if plane_count(format) > 1 {
            vk::ImageAspectFlags::PLANE_0
        } else {
            vk::ImageAspectFlags::COLOR
        });
    }

    let texture_format =
        map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("texture format of {format:?}")))?;
    Ok(match texture_format.order {
        ChannelOrder::D | ChannelOrder::DS => vk::ImageAspectFlags::DEPTH,
        ChannelOrder::S => vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::COLOR,
    })
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    MemoryRequirements,
    SubresourceLayout,
}

#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    array_layers: u32,
    /// 0 means "full mip chain".
    mip_levels: u32,
    tiling_scheme: TilingScheme,
    usage: vk::ImageUsageFlags,
}

/// `getFullMipLevels`
fn get_full_mip_levels(format: vk::Format, extent: vk::Extent3D) -> u32 {
    let mut mipmap_edge = extent.width.max(extent.height).max(extent.depth);

    // The smallest plane of a chroma-subsampled format limits the chain.
    if is_ycbcr_format(format) {
        let alignment = get_image_size_alignment(format);
        if alignment[0] > 1 {
            mipmap_edge = mipmap_edge.min(extent.width / alignment[0]);
        }
        if alignment[1] > 1 {
            mipmap_edge = mipmap_edge.min(extent.height / alignment[1]);
        }
        if alignment[2] > 1 {
            mipmap_edge = mipmap_edge.min(extent.depth / alignment[2]);
        }
    }

    let mut levels = 1u32;
    let mut dim = mipmap_edge;
    while dim > 1 {
        levels += 1;
        dim >>= 1;
    }
    levels
}

fn get_effective_mip_levels(params: &TestParams) -> u32 {
    if params.mip_levels == 0 {
        get_full_mip_levels(params.format, params.extent)
    } else {
        params.mip_levels
    }
}

/// `getDrmFormatModifiers`
#[allow(unused_assignments)]
fn get_drm_format_modifiers(context: &Context<'_>, format: vk::Format) -> Vec<u64> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut modifier_list = vk::DrmFormatModifierPropertiesListEXT::default();
    let mut format_properties = vk::FormatProperties2::default();
    format_properties.next = std::ptr::addr_of_mut!(modifier_list).cast();
    unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };

    let mut modifier_properties =
        vec![vk::DrmFormatModifierPropertiesEXT::default(); modifier_list.drm_format_modifier_count as usize];
    modifier_list.drm_format_modifier_properties = modifier_properties.as_mut_ptr();
    unsafe { instance.get_physical_device_format_properties2(physical_device, format, &mut format_properties) };

    modifier_properties
        .iter()
        .map(|props| props.drm_format_modifier)
        .collect()
}

/// `getCompatibleModifiers`
fn get_compatible_modifiers(
    context: &Context<'_>,
    format: vk::Format,
    image_type: vk::ImageType,
    usage: vk::ImageUsageFlags,
) -> Result<Vec<u64>, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let mut compatible_modifiers = Vec::new();

    for modifier in get_drm_format_modifiers(context, format) {
        let mut modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT::default();
        modifier_info.drm_format_modifier = modifier;
        modifier_info.sharing_mode = vk::SharingMode::EXCLUSIVE;

        let mut format_list_info = vk::ImageFormatListCreateInfo::default();
        format_list_info.next = std::ptr::addr_of!(modifier_info).cast();
        format_list_info.view_format_count = 1;
        format_list_info.view_formats = &format;

        let mut image_format_info = vk::PhysicalDeviceImageFormatInfo2::default();
        image_format_info.next = std::ptr::addr_of!(format_list_info).cast();
        image_format_info.format = format;
        image_format_info.type_ = image_type;
        image_format_info.tiling = vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT;
        image_format_info.usage = usage;

        let mut image_format_properties = vk::ImageFormatProperties2::default();
        match unsafe {
            instance.get_physical_device_image_format_properties2(
                physical_device,
                &image_format_info,
                &mut image_format_properties,
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => continue,
            result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
        }

        compatible_modifiers.push(modifier);
    }

    Ok(compatible_modifiers)
}

/// `DrmModifierChain` - storage for the structures a DRM-format-modifier image chains into its pNext.
struct DrmModifierChain {
    modifier_list_info: vk::ImageDrmFormatModifierListCreateInfoEXT,
    format_list_info: vk::ImageFormatListCreateInfo,
    format: vk::Format,
}

impl DrmModifierChain {
    fn new() -> Self {
        Self {
            modifier_list_info: vk::ImageDrmFormatModifierListCreateInfoEXT::default(),
            format_list_info: vk::ImageFormatListCreateInfo::default(),
            format: vk::Format::UNDEFINED,
        }
    }
}

/// `makeImageCreateInfo`
fn make_image_create_info(
    params: &TestParams,
    mode: TilingMode,
    tiling_control_info: &mut ImageTilingControlCreateInfoExt,
    drm_chain: &mut DrmModifierChain,
    modifiers: &[u64],
) -> vk::ImageCreateInfo {
    let mut create_info = vk::ImageCreateInfo::default();
    create_info.flags = vk::ImageCreateFlags::empty();
    create_info.image_type = params.image_type;
    create_info.format = params.format;
    create_info.extent = params.extent;
    create_info.mip_levels = get_effective_mip_levels(params);
    create_info.array_layers = params.array_layers;
    create_info.samples = vk::SampleCountFlags::_1;
    create_info.tiling = get_vk_tiling(params.tiling_scheme);
    create_info.usage = params.usage;
    create_info.sharing_mode = vk::SharingMode::EXCLUSIVE;
    create_info.initial_layout = vk::ImageLayout::UNDEFINED;

    let mut p_next_head: *const c_void = std::ptr::null();

    if params.tiling_scheme == TilingScheme::DrmModifier {
        drm_chain.format = params.format;

        drm_chain.modifier_list_info = vk::ImageDrmFormatModifierListCreateInfoEXT::default();
        drm_chain.modifier_list_info.drm_format_modifier_count = modifiers.len() as u32;
        drm_chain.modifier_list_info.drm_format_modifiers = modifiers.as_ptr();

        drm_chain.format_list_info = vk::ImageFormatListCreateInfo::default();
        drm_chain.format_list_info.next = std::ptr::addr_of!(drm_chain.modifier_list_info).cast();
        drm_chain.format_list_info.view_format_count = 1;
        drm_chain.format_list_info.view_formats = std::ptr::addr_of!(drm_chain.format);

        p_next_head = std::ptr::addr_of!(drm_chain.format_list_info).cast();
    }

    if mode != TilingMode::Unspecified {
        tiling_control_info.tiling_control = get_tiling_control_value(mode);
        tiling_control_info.next = p_next_head;
        p_next_head = std::ptr::addr_of!(*tiling_control_info).cast();
    }

    create_info.next = p_next_head;

    create_info
}

#[derive(Clone, Copy)]
struct Requirements {
    size: vk::DeviceSize,
    alignment: vk::DeviceSize,
    memory_type_bits: u32,
}

impl Requirements {
    fn new(req: &vk::MemoryRequirements) -> Self {
        Self {
            size: req.size,
            alignment: req.alignment,
            memory_type_bits: req.memory_type_bits,
        }
    }
}

/// `getCreatedImageMemoryRequirements` - vkCreateImage + vkGetImageMemoryRequirements2
fn get_created_image_memory_requirements(
    device: &Device,
    create_info: &vk::ImageCreateInfo,
) -> Result<Requirements, TestError> {
    let image = Unique::new(
        device,
        unsafe { device.create_image(create_info, None) }.vk_check("vkCreateImage")?,
    );

    let mut info = vk::ImageMemoryRequirementsInfo2::default();
    info.image = *image;

    let mut req = vk::MemoryRequirements2::default();
    unsafe { device.get_image_memory_requirements2(&info, &mut req) };

    Ok(Requirements::new(&req.memory_requirements))
}

/// `getCreationlessImageMemoryRequirements` - vkGetDeviceImageMemoryRequirements
fn get_creationless_image_memory_requirements(
    context: &Context<'_>,
    create_info: &vk::ImageCreateInfo,
) -> Requirements {
    let device = context.get_device();

    let mut info = vk::DeviceImageMemoryRequirements::default();
    info.create_info = create_info;
    info.plane_aspect = vk::ImageAspectFlags::empty();

    let mut req = vk::MemoryRequirements2::default();
    if context.api_version() >= (1, 3, 0) {
        unsafe { device.get_device_image_memory_requirements(&info, &mut req) };
    } else {
        unsafe { device.get_device_image_memory_requirements_khr(&info, &mut req) };
    }

    Requirements::new(&req.memory_requirements)
}

/// `getCreatedImageSubresourceLayout` - vkCreateImage + vkGetImageSubresourceLayout
fn get_created_image_subresource_layout(
    device: &Device,
    create_info: &vk::ImageCreateInfo,
    subresource: &vk::ImageSubresource,
) -> Result<vk::SubresourceLayout, TestError> {
    let image = Unique::new(
        device,
        unsafe { device.create_image(create_info, None) }.vk_check("vkCreateImage")?,
    );
    Ok(unsafe { device.get_image_subresource_layout(*image, subresource) })
}

/// `getCreationlessImageSubresourceLayout` - vkGetDeviceImageSubresourceLayout
fn get_creationless_image_subresource_layout(
    device: &Device,
    create_info: &vk::ImageCreateInfo,
    subresource: &vk::ImageSubresource,
) -> vk::SubresourceLayout {
    let mut subresource2 = vk::ImageSubresource2::default();
    subresource2.image_subresource = *subresource;

    let mut info = vk::DeviceImageSubresourceInfo::default();
    info.create_info = create_info;
    info.subresource = &subresource2;

    let mut layout2 = vk::SubresourceLayout2::default();
    unsafe { device.get_device_image_subresource_layout_khr(&info, &mut layout2) };

    layout2.subresource_layout
}

fn requirements_to_string(req: &Requirements) -> String {
    format!(
        "size={}, alignment={}, memoryTypeBits=0x{:x}",
        req.size, req.alignment, req.memory_type_bits
    )
}

struct TilingControlInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TilingControlInstance<'_> {
    /// `getImageModifiers` - empty for optimal tiling.
    fn get_image_modifiers(&self) -> Result<Vec<u64>, TestError> {
        if self.params.tiling_scheme != TilingScheme::DrmModifier {
            return Ok(Vec::new());
        }

        get_compatible_modifiers(
            self.context,
            self.params.format,
            self.params.image_type,
            self.params.usage,
        )
    }

    /// `iterateMemoryRequirements`
    fn iterate_memory_requirements(&self) -> TestOutcome {
        let device = self.context.get_device();
        let modifiers = self.get_image_modifiers()?;

        let mut per_mode = [Requirements {
            size: 0,
            alignment: 0,
            memory_type_bits: 0,
        }; 4];

        for mode in MODES {
            let mut tiling_control_info = ImageTilingControlCreateInfoExt::new();
            let mut drm_chain = DrmModifierChain::new();
            let create_info =
                make_image_create_info(&self.params, mode, &mut tiling_control_info, &mut drm_chain, &modifiers);

            let created = get_created_image_memory_requirements(device, &create_info)?;
            let creationless = get_creationless_image_memory_requirements(self.context, &create_info);

            log::info!(
                "{}: created {{{}}}, creationless {{{}}}",
                get_tiling_mode_name(mode),
                requirements_to_string(&created),
                requirements_to_string(&creationless)
            );

            if created.size != creationless.size || created.memory_type_bits != creationless.memory_type_bits {
                return Ok(TestStatus::fail(format!(
                    "Created vs creationless memory requirements differ for {}",
                    get_tiling_mode_name(mode)
                )));
            }

            per_mode[mode as usize] = created;
        }

        let min_space_req = per_mode[TilingMode::MinSize as usize];

        for mode in MODES {
            if mode == TilingMode::MinSize {
                continue;
            }

            let mode_req = per_mode[mode as usize];
            if min_space_req.size > mode_req.size {
                return Ok(TestStatus::fail(format!(
                    "MIN_SIZE size ({}) is larger than {} size ({})",
                    min_space_req.size,
                    get_tiling_mode_name(mode),
                    mode_req.size
                )));
            }
        }

        // An absent VkImageTilingControlCreateInfoEXT must behave exactly like DEFAULT.
        let unspecified_req = per_mode[TilingMode::Unspecified as usize];
        let default_req = per_mode[TilingMode::Default as usize];
        if unspecified_req.size != default_req.size || unspecified_req.alignment != default_req.alignment {
            return Ok(TestStatus::fail(format!(
                "Unspecified tiling control (size={}, alignment={}) differs from default (size={}, alignment={})",
                unspecified_req.size, unspecified_req.alignment, default_req.size, default_req.alignment
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `iterateSubresourceLayout`
    fn iterate_subresource_layout(&self) -> TestOutcome {
        let device = self.context.get_device();
        let modifiers = self.get_image_modifiers()?;

        let subresource = vk::ImageSubresource {
            aspect_mask: get_subresource_aspect(self.params.format, self.params.tiling_scheme)?,
            mip_level: 0,
            array_layer: 0,
        };

        let mut per_mode_size = [0 as vk::DeviceSize; 4];

        for mode in MODES {
            let mut tiling_control_info = ImageTilingControlCreateInfoExt::new();
            let mut drm_chain = DrmModifierChain::new();
            let create_info =
                make_image_create_info(&self.params, mode, &mut tiling_control_info, &mut drm_chain, &modifiers);

            let created = get_created_image_subresource_layout(device, &create_info, &subresource)?;
            let creationless = get_creationless_image_subresource_layout(device, &create_info, &subresource);

            log::info!(
                "{}: created {{offset={}, size={}, rowPitch={}, arrayPitch={}, depthPitch={}}}, creationless {{offset={}, size={}, rowPitch={}, arrayPitch={}, depthPitch={}}}",
                get_tiling_mode_name(mode),
                created.offset,
                created.size,
                created.row_pitch,
                created.array_pitch,
                created.depth_pitch,
                creationless.offset,
                creationless.size,
                creationless.row_pitch,
                creationless.array_pitch,
                creationless.depth_pitch
            );

            if created.offset != creationless.offset
                || created.size != creationless.size
                || created.row_pitch != creationless.row_pitch
                || created.array_pitch != creationless.array_pitch
                || created.depth_pitch != creationless.depth_pitch
            {
                return Ok(TestStatus::fail(format!(
                    "Created vs creationless subresource layout differ for {}",
                    get_tiling_mode_name(mode)
                )));
            }

            per_mode_size[mode as usize] = created.size;
        }

        let min_space_size = per_mode_size[TilingMode::MinSize as usize];

        for mode in MODES {
            if mode == TilingMode::MinSize {
                continue;
            }

            let mode_size = per_mode_size[mode as usize];
            if min_space_size > mode_size {
                return Ok(TestStatus::fail(format!(
                    "MIN_SIZE subresource size ({}) is larger than {} size ({})",
                    min_space_size,
                    get_tiling_mode_name(mode),
                    mode_size
                )));
            }
        }

        // An absent VkImageTilingControlCreateInfoEXT must behave exactly like DEFAULT.
        let unspecified_size = per_mode_size[TilingMode::Unspecified as usize];
        let default_size = per_mode_size[TilingMode::Default as usize];
        if unspecified_size != default_size {
            return Ok(TestStatus::fail(format!(
                "Unspecified tiling control subresource size ({unspecified_size}) differs from default ({default_size})"
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for TilingControlInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.params.test_type == TestType::MemoryRequirements {
            self.iterate_memory_requirements()
        } else {
            self.iterate_subresource_layout()
        }
    }
}

/// `getImageTilingControlFeaturesEXT().imageTilingControl`
fn image_tiling_control_supported(context: &Context<'_>) -> bool {
    let mut tiling_features = ImageTilingControlFeaturesExt {
        s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_PHYSICAL_DEVICE_IMAGE_TILING_CONTROL_FEATURES_EXT),
        next: std::ptr::null_mut(),
        image_tiling_control: vk::FALSE,
    };
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    features2.next = std::ptr::addr_of_mut!(tiling_features).cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    tiling_features.image_tiling_control != vk::FALSE
}

struct TilingControlCase {
    name: String,
    params: TestParams,
}

impl TestCase for TilingControlCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        context.require_device_functionality("VK_EXT_image_tiling_control")?;

        if params.test_type == TestType::MemoryRequirements {
            context.require_device_functionality("VK_KHR_maintenance4")?;
        } else {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        if is_ycbcr_format(params.format) {
            context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;

            let mut ycbcr_features = vk::PhysicalDeviceSamplerYcbcrConversionFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut ycbcr_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if ycbcr_features.sampler_ycbcr_conversion == vk::FALSE {
                return Err(TestError::NotSupported(
                    "samplerYcbcrConversion feature not supported".to_string(),
                ));
            }
        }

        if !image_tiling_control_supported(context) {
            return Err(TestError::NotSupported(
                "imageTilingControl feature not supported".to_string(),
            ));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if params.tiling_scheme == TilingScheme::DrmModifier {
            context.require_device_functionality("VK_EXT_image_drm_format_modifier")?;

            if get_compatible_modifiers(context, params.format, params.image_type, params.usage)?.is_empty() {
                return Err(TestError::NotSupported("No matching DRM modifier".to_string()));
            }

            return Ok(());
        }

        // Verify the format/type/tiling/usage combination and its extents are supported.
        let format_properties = match unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                params.format,
                params.image_type,
                get_vk_tiling(params.tiling_scheme),
                params.usage,
                vk::ImageCreateFlags::empty(),
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "Image format/type/tiling/usage combination not supported".to_string(),
                ));
            }
            result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?,
        };

        if params.extent.width > format_properties.max_extent.width
            || params.extent.height > format_properties.max_extent.height
            || params.extent.depth > format_properties.max_extent.depth
        {
            return Err(TestError::NotSupported("Image extent not supported".to_string()));
        }

        if get_effective_mip_levels(params) > format_properties.max_mip_levels {
            return Err(TestError::NotSupported(
                "Required number of mip levels not supported".to_string(),
            ));
        }

        if params.array_layers > format_properties.max_array_layers {
            return Err(TestError::NotSupported(
                "Required number of array layers not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TilingControlInstance {
            context,
            params: self.params,
        })
    }
}

/// `getFormatSimpleName` for the formats this group names.
fn format_simple_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::R16G16B16A16_SFLOAT => "r16g16b16a16_sfloat",
        vk::Format::R32G32B32A32_SFLOAT => "r32g32b32a32_sfloat",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        vk::Format::S8_UINT => "s8_uint",
        vk::Format::G8_B8_R8_3PLANE_420_UNORM => "g8_b8_r8_3plane_420_unorm",
        _ => "g8b8g8r8_422_unorm",
    }
}

fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| matches!(f.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS))
}

/// `getCaseName`
fn get_case_name(params: &TestParams) -> String {
    let mut name = format!("{}x{}", params.extent.width, params.extent.height);
    if params.image_type == vk::ImageType::_3D {
        name.push_str(&format!("x{}", params.extent.depth));
    }
    if params.array_layers > 1 {
        name.push_str(&format!("_{}layers", params.array_layers));
    }
    name.push_str(if params.mip_levels == 0 { "_full_mips" } else { "_1_mip" });
    name.push_str(if params.tiling_scheme == TilingScheme::DrmModifier {
        "_drm_modifier"
    } else {
        "_optimal"
    });
    name
}

/// `addOptimalMemoryRequirementCases`
fn add_optimal_memory_requirement_cases(cases: &mut Vec<TestParams>, format: vk::Format) {
    let usage = vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    let geometries = [
        (
            vk::ImageType::_2D,
            vk::Extent3D {
                width: 256,
                height: 256,
                depth: 1,
            },
            1u32,
        ),
        (
            vk::ImageType::_2D,
            vk::Extent3D {
                width: 1024,
                height: 1024,
                depth: 1,
            },
            1,
        ),
        (
            vk::ImageType::_2D,
            vk::Extent3D {
                width: 256,
                height: 256,
                depth: 1,
            },
            6,
        ),
        (
            vk::ImageType::_3D,
            vk::Extent3D {
                width: 64,
                height: 64,
                depth: 64,
            },
            1,
        ),
    ];

    for (image_type, extent, layers) in geometries {
        // Depth/stencil and YCbCr formats are only valid as 2D images.
        if image_type != vk::ImageType::_2D && (is_depth_stencil_format(format) || is_ycbcr_format(format)) {
            continue;
        }

        for mips in [0u32, 1] {
            cases.push(TestParams {
                test_type: TestType::MemoryRequirements,
                image_type,
                format,
                extent,
                array_layers: layers,
                mip_levels: mips,
                tiling_scheme: TilingScheme::Optimal,
                usage,
            });
        }
    }
}

/// `addDrmModifierCases`
fn add_drm_modifier_cases(cases: &mut Vec<TestParams>, test_type: TestType, format: vk::Format) {
    let usage = vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::COLOR_ATTACHMENT;

    for extent in [
        vk::Extent3D {
            width: 128,
            height: 128,
            depth: 1,
        },
        vk::Extent3D {
            width: 1024,
            height: 1024,
            depth: 1,
        },
    ] {
        cases.push(TestParams {
            test_type,
            image_type: vk::ImageType::_2D,
            format,
            extent,
            array_layers: 1,
            mip_levels: 1,
            tiling_scheme: TilingScheme::DrmModifier,
            usage,
        });
    }
}

/// `addTilingControlCases`
fn add_tiling_control_cases(group: &mut TestCaseGroup, test_type: TestType) {
    let formats = [
        vk::Format::R8_UNORM,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::D32_SFLOAT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::S8_UINT,
        vk::Format::G8_B8_R8_3PLANE_420_UNORM,
        vk::Format::G8B8G8R8_422_UNORM,
    ];

    for format in formats {
        if is_ycbcr_format(format) && plane_count(format) > 1 {
            continue;
        }

        let mut format_group = TestCaseGroup::new(format_simple_name(format));

        let mut cases = Vec::new();

        // Optimal tiling is not queryable by vkGetImageSubresourceLayout, so memory_requirements covers optimal + DRM
        // modifier, while subresource_layout covers DRM modifier only.
        if test_type == TestType::MemoryRequirements {
            add_optimal_memory_requirement_cases(&mut cases, format);
        }
        add_drm_modifier_cases(&mut cases, test_type, format);

        for params in cases {
            format_group.add_child(Box::new(TilingControlCase {
                name: get_case_name(&params),
                params,
            }) as Box<dyn TestCase>);
        }

        group.add_child(format_group);
    }
}

struct AlignmentControlInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for AlignmentControlInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let instance = self.context.get_instance();
        let physical_device = self.context.get_physical_device();
        let device = self.context.get_device();

        let mut alignment_properties = vk::PhysicalDeviceImageAlignmentControlPropertiesMESA::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::default();
        properties2.next = std::ptr::addr_of_mut!(alignment_properties).cast();
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };

        // A 1024x1024 R8G8B8A8_UNORM image with 1 mip and 1 layer.
        let image_params = TestParams {
            test_type: TestType::MemoryRequirements,
            image_type: vk::ImageType::_2D,
            format: vk::Format::R8G8B8A8_UNORM,
            extent: vk::Extent3D {
                width: 1024,
                height: 1024,
                depth: 1,
            },
            array_layers: 1,
            mip_levels: 1,
            tiling_scheme: TilingScheme::Optimal,
            usage: vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        };

        let mask = alignment_properties.supported_image_alignment_mask;
        log::info!("supportedImageAlignmentMask = 0x{mask:x}");

        // Memory requirements for the fixed image with a MESA alignment hint, optionally with a tiling control hint,
        // also checking created vs creationless parity. Returns the resulting alignment.
        let query_alignment =
            |mode: TilingMode, maximum_requested_alignment: u32| -> Result<vk::DeviceSize, TestError> {
                let mut alignment_info = vk::ImageAlignmentControlCreateInfoMESA::default();
                alignment_info.maximum_requested_alignment = maximum_requested_alignment;

                let mut tiling_control_info = ImageTilingControlCreateInfoExt::new();
                let mut drm_chain = DrmModifierChain::new();
                let mut create_info =
                    make_image_create_info(&image_params, mode, &mut tiling_control_info, &mut drm_chain, &[]);
                alignment_info.next = create_info.next;
                create_info.next = std::ptr::addr_of!(alignment_info).cast();

                let created = get_created_image_memory_requirements(device, &create_info)?;
                let creationless = get_creationless_image_memory_requirements(self.context, &create_info);

                log::info!(
                    "  {}: created {{{}}}, creationless {{{}}}",
                    get_tiling_mode_name(mode),
                    requirements_to_string(&created),
                    requirements_to_string(&creationless)
                );

                if created.size != creationless.size
                    || created.alignment != creationless.alignment
                    || created.memory_type_bits != creationless.memory_type_bits
                {
                    return Err(TestError::Fail(format!(
                        "Created vs creationless memory requirements differ for {} maximumRequestedAlignment={}",
                        get_tiling_mode_name(mode),
                        maximum_requested_alignment
                    )));
                }

                Ok(created.alignment)
            };

        let mut bit = 1u32;
        while bit != 0 {
            let current = bit;
            bit = bit.wrapping_shl(1);

            if mask & current == 0 {
                continue;
            }

            let maximum_requested_alignment = current;
            log::info!("Testing maximumRequestedAlignment = {maximum_requested_alignment}");

            // The spec lets the implementation return a larger alignment than requested, so a baseline above the request
            // means the hint isn't honored and there is nothing to compare against.
            let baseline_alignment = query_alignment(TilingMode::Unspecified, maximum_requested_alignment)?;
            if baseline_alignment > vk::DeviceSize::from(maximum_requested_alignment) {
                log::info!("  baseline alignment not honored, skipping MAX_PERFORMANCE check");
                continue;
            }

            // The MESA hint was honored on its own, so adding MAX_PERFORMANCE must not push the alignment above it.
            let perf_alignment = query_alignment(TilingMode::MaxPerformance, maximum_requested_alignment)?;
            if perf_alignment > vk::DeviceSize::from(maximum_requested_alignment) {
                return Ok(TestStatus::fail(format!(
                    "MAX_PERFORMANCE alignment ({perf_alignment}) exceeds maximumRequestedAlignment ({maximum_requested_alignment}) even though the baseline honored it"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct AlignmentControlCase {
    name: &'static str,
}

impl TestCase for AlignmentControlCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_image_tiling_control")?;
        context.require_device_functionality("VK_KHR_maintenance4")?;
        context.require_device_functionality("VK_MESA_image_alignment_control")?;

        if !image_tiling_control_supported(context) {
            return Err(TestError::NotSupported(
                "imageTilingControl feature not supported".to_string(),
            ));
        }

        let mut alignment_features = vk::PhysicalDeviceImageAlignmentControlFeaturesMESA::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::default();
        features2.next = std::ptr::addr_of_mut!(alignment_features).cast();
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if alignment_features.image_alignment_control == vk::FALSE {
            return Err(TestError::NotSupported(
                "imageAlignmentControl feature not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AlignmentControlInstance { context })
    }
}

/// `createImageTilingControlTests`
pub fn create_image_tiling_control_tests() -> TestCaseGroup {
    let mut root_group = TestCaseGroup::new("tiling_control");

    let mut mem_req_group = TestCaseGroup::new("memory_requirements");
    add_tiling_control_cases(&mut mem_req_group, TestType::MemoryRequirements);
    root_group.add_child(mem_req_group);

    let mut subresource_group = TestCaseGroup::new("subresource_layout");
    add_tiling_control_cases(&mut subresource_group, TestType::SubresourceLayout);
    root_group.add_child(subresource_group);

    let mut align_group = TestCaseGroup::new("alignment_control");
    align_group.add_child(Box::new(AlignmentControlCase {
        name: "supported_alignments",
    }) as Box<dyn TestCase>);
    root_group.add_child(align_group);

    root_group
}
