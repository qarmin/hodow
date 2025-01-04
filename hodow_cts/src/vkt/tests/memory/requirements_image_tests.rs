// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryRequirementsTests.cpp
//   (the image and multiplane_image halves; the buffer half is in requirements_tests.rs)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `ImageMemoryRequirementsOriginal` -> `Extended` -> `DedicatedAllocation` / `CreateInfo`
// class hierarchy is one struct with an `ImageVariant` here, exactly as `BufferMemoryRequirements`
// does it in requirements_tests.rs: each virtual call is a `match` that keeps the layering.
//
// The ASTC 3D arm of `isImageSupported` is not ported: no ASTC 3D format is in `formats::allFormats`,
// which is the only list this test walks.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_3, InstanceV1_1, KhrMaintenance4ExtensionDeviceCommands};

use super::requirements_tests::{bits_to_indices, require_promoted_to_1_1, valid_value_vk_bool32};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::memory_requirement_invariance_tests::{all_formats, is_ycbcr_format};
use crate::vkt::tests::ycbcr::util::{format_description, plane_aspect};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `ImageTestParams`
#[derive(Clone, Copy)]
pub struct ImageTestParams {
    pub flags: vk::ImageCreateFlags,
    pub tiling: vk::ImageTiling,
    pub transient: bool,
    pub use_maint4: bool,
}

/// Which of upstream's four `IImageMemoryRequirements` subclasses is running.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ImageVariant {
    /// `ImageMemoryRequirementsOriginal`
    Original,
    /// `ImageMemoryRequirementsExtended`
    Extended,
    /// `ImageMemoryRequirementsDedicatedAllocation`
    DedicatedAllocation,
    /// `ImageMemoryRequirementsCreateInfo`
    CreateInfo,
}

const SPARSE_FLAGS: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(
    vk::ImageCreateFlags::SPARSE_BINDING.bits()
        | vk::ImageCreateFlags::SPARSE_RESIDENCY.bits()
        | vk::ImageCreateFlags::SPARSE_ALIASED.bits(),
);

/// `nextFlag`
fn next_flag(value: u32) -> u32 {
    if value != 0 { value << 1 } else { 1 }
}

/// `nextFlagExcluding`
fn next_flag_excluding(value: u32, excluded_flags: u32) -> u32 {
    let mut tmp = value;
    loop {
        tmp = next_flag(tmp);
        if tmp & excluded_flags == 0 {
            return tmp;
        }
    }
}

/// `isDepthStencilFormat` for the core depth and stencil formats, which are laid out next to
/// each other in the enum (`D16_UNORM` .. `D32_SFLOAT_S8_UINT`).
fn is_depth_stencil_format(format: vk::Format) -> bool {
    (vk::Format::D16_UNORM.as_raw()..=vk::Format::D32_SFLOAT_S8_UINT.as_raw()).contains(&format.as_raw())
}

/// `vk::isYCbCrConversionFormat`: the YCbCr formats minus the four `R10X6`/`R12X4` ones that carry
/// no chroma, plus the four 2-plane 444 extension formats.
fn is_ycbcr_conversion_format(format: vk::Format) -> bool {
    let raw = format.as_raw();
    if (1000330000..=1000330003).contains(&raw) {
        return true;
    }
    if !(1000156000..=1000156033).contains(&raw) {
        return false;
    }
    ![7, 8, 17, 18].iter().any(|offset| raw == 1000156000 + offset)
}

/// `formats::planarFormats`
fn planar_formats() -> Vec<vk::Format> {
    let mut formats = Vec::new();
    for offset in [
        2, 3, 4, 5, 6, 12, 13, 14, 15, 16, 22, 23, 24, 25, 26, 29, 30, 31, 32, 33,
    ] {
        formats.push(vk::Format::from_raw(1000156000 + offset));
    }
    formats.extend((1000330000..=1000330003).map(vk::Format::from_raw));
    formats
}

/// `vk::getPlaneCount`, answered from the plane table of the YCbCr tests.
fn get_plane_count(format: vk::Format) -> usize {
    format_description(format).planes.len()
}

/// `getImageMemoryRequirements2`
fn get_image_memory_requirements2(
    vk: &Device,
    create_info: &vk::ImageCreateInfo,
    next: Option<&mut vk::MemoryDedicatedRequirements>,
) -> Result<vk::MemoryRequirements, TestError> {
    let raw_image = unsafe { vk.create_image(create_info, None) }.vk_check("vkCreateImage")?;
    let image = Unique::new(vk, raw_image);

    let info = vk::ImageMemoryRequirementsInfo2 {
        s_type: vk::StructureType::IMAGE_MEMORY_REQUIREMENTS_INFO_2,
        next: std::ptr::null(),
        image: *image,
    };
    let mut req2 = vk::MemoryRequirements2::default();
    if let Some(next) = next {
        req2.next = (next as *mut vk::MemoryDedicatedRequirements).cast();
    }

    unsafe { vk.get_image_memory_requirements2(&info, &mut req2) };

    Ok(req2.memory_requirements)
}

/// `getDeviceImageMemoryRequirements`, from core 1.3 or from VK_KHR_maintenance4 as the device has it.
fn get_device_image_memory_requirements(
    context: &Context<'_>,
    create_info: &vk::ImageCreateInfo,
) -> vk::MemoryRequirements {
    let vk = context.get_device();
    let info = vk::DeviceImageMemoryRequirements {
        s_type: vk::StructureType::DEVICE_IMAGE_MEMORY_REQUIREMENTS,
        next: std::ptr::null(),
        create_info,
        plane_aspect: vk::ImageAspectFlags::empty(),
    };
    let mut req2 = vk::MemoryRequirements2::default();

    if context.api_version() >= (1, 3, 0) {
        unsafe { vk.get_device_image_memory_requirements(&info, &mut req2) };
    } else {
        unsafe { vk.get_device_image_memory_requirements_khr(&info, &mut req2) };
    }

    req2.memory_requirements
}

/// `getDeviceImageSparseMemoryRequirements`
fn get_device_image_sparse_memory_requirements(
    context: &Context<'_>,
    create_info: &vk::ImageCreateInfo,
    plane_aspect: vk::ImageAspectFlags,
) -> Vec<vk::SparseImageMemoryRequirements> {
    let vk = context.get_device();
    let info = vk::DeviceImageMemoryRequirements {
        s_type: vk::StructureType::DEVICE_IMAGE_MEMORY_REQUIREMENTS,
        next: std::ptr::null(),
        create_info,
        plane_aspect,
    };

    let requirements2 = if context.api_version() >= (1, 3, 0) {
        unsafe { vk.get_device_image_sparse_memory_requirements(&info) }
    } else {
        unsafe { vk.get_device_image_sparse_memory_requirements_khr(&info) }
    };

    requirements2.iter().map(|item| item.memory_requirements).collect()
}

/// `getImageCreateInfoSparseMemoryRequirements`
fn get_image_create_info_sparse_memory_requirements(
    context: &Context<'_>,
    create_info: &vk::ImageCreateInfo,
) -> Vec<vk::SparseImageMemoryRequirements> {
    get_device_image_sparse_memory_requirements(context, create_info, vk::ImageAspectFlags::empty())
}

/// `checkSparseImageFormatSupport`
fn check_sparse_image_format_support(context: &Context<'_>, info: &vk::ImageCreateInfo) -> bool {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_sparse_image_format_properties(
                context.get_physical_device(),
                info.format,
                info.image_type,
                info.samples,
                info.usage,
                info.tiling,
            )
    };
    !properties.is_empty()
}

/// `isUsageMatchesFeatures`
fn is_usage_matches_features(usage: vk::ImageUsageFlags, feature_flags: vk::FormatFeatureFlags) -> bool {
    if usage.contains(vk::ImageUsageFlags::SAMPLED) && feature_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE) {
        return true;
    }
    if usage.contains(vk::ImageUsageFlags::STORAGE) && feature_flags.contains(vk::FormatFeatureFlags::STORAGE_IMAGE) {
        return true;
    }
    if usage.intersects(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT)
        && feature_flags.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
    {
        return true;
    }
    if usage.contains(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
        && feature_flags.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
    {
        return true;
    }

    false
}

/// `doesUsageSatisfyFeatures`
fn does_usage_satisfy_features(usage: vk::ImageUsageFlags, feature_flags: vk::FormatFeatureFlags) -> bool {
    let mut ans = true;

    if usage.contains(vk::ImageUsageFlags::SAMPLED) {
        ans &= feature_flags.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE);
    }
    if usage.contains(vk::ImageUsageFlags::STORAGE) {
        ans &= feature_flags.contains(vk::FormatFeatureFlags::STORAGE_IMAGE);
    }
    if usage.intersects(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT) {
        ans &= feature_flags.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT);
    }
    if usage.contains(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT) {
        ans &= feature_flags.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT);
    }

    ans
}

/// `ImageMemoryRequirementsOriginal::isImageSupported` - catches both invalid and legal but unsupported
/// combinations of image parameters.
fn is_image_supported(context: &Context<'_>, info: &vk::ImageCreateInfo) -> bool {
    let vki = context.get_instance();
    let phys_device = context.get_physical_device();

    if !context.is_device_functionality_supported("VK_KHR_maintenance5")
        && (info.format == vk::Format::A8_UNORM || info.format == vk::Format::A1B5G5R5_UNORM_PACK16)
    {
        return false;
    }

    if is_ycbcr_format(info.format)
        && (info.image_type != vk::ImageType::_2D
            || info.mip_levels != 1
            || info.array_layers != 1
            || info.samples != vk::SampleCountFlags::_1
            || !context.is_device_functionality_supported("VK_KHR_sampler_ycbcr_conversion"))
    {
        return false;
    }

    if info.flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE) && info.image_type != vk::ImageType::_2D {
        return false;
    }

    if info.samples != vk::SampleCountFlags::_1
        && (info.image_type != vk::ImageType::_2D
            || info.flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE)
            || info.tiling != vk::ImageTiling::OPTIMAL
            || info.mip_levels > 1)
    {
        return false;
    }

    if info.usage.contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT)
        && !info.usage.intersects(
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        )
    {
        return false;
    }

    let features = unsafe { vki.get_physical_device_features(phys_device) };

    if info.flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY) {
        if info.image_type == vk::ImageType::_1D {
            return false;
        }

        if info.image_type == vk::ImageType::_2D && features.sparse_residency_image_2d == vk::FALSE {
            return false;
        }
        if info.image_type == vk::ImageType::_3D && features.sparse_residency_image_3d == vk::FALSE {
            return false;
        }
        if info.samples == vk::SampleCountFlags::_2 && features.sparse_residency2_samples == vk::FALSE {
            return false;
        }
        if info.samples == vk::SampleCountFlags::_4 && features.sparse_residency4_samples == vk::FALSE {
            return false;
        }
        if info.samples == vk::SampleCountFlags::_8 && features.sparse_residency8_samples == vk::FALSE {
            return false;
        }
        if info.samples == vk::SampleCountFlags::_16 && features.sparse_residency16_samples == vk::FALSE {
            return false;
        }
        if info.samples == vk::SampleCountFlags::_32 || info.samples == vk::SampleCountFlags::_64 {
            return false;
        }
    }

    if info.samples != vk::SampleCountFlags::_1
        && info.usage.contains(vk::ImageUsageFlags::STORAGE)
        && features.shader_storage_image_multisample == vk::FALSE
    {
        return false;
    }

    match info.format.as_raw() {
        // BC1_RGB_UNORM_BLOCK ..= BC7_SRGB_BLOCK
        131..=146 => {
            if features.texture_compression_bc == vk::FALSE {
                return false;
            }
        }
        // ETC2_R8G8B8_UNORM_BLOCK ..= EAC_R11G11_SNORM_BLOCK
        147..=156 => {
            if features.texture_compression_etc2 == vk::FALSE {
                return false;
            }
        }
        // ASTC_4x4_UNORM_BLOCK ..= ASTC_12x12_SRGB_BLOCK
        157..=184 if features.texture_compression_astc_ldr == vk::FALSE => {
            return false;
        }
        _ => {}
    }

    let format_properties = unsafe { vki.get_physical_device_format_properties(phys_device, info.format) };
    let format_features = if info.tiling == vk::ImageTiling::LINEAR {
        format_properties.linear_tiling_features
    } else {
        format_properties.optimal_tiling_features
    };

    if !is_usage_matches_features(info.usage, format_features) {
        return false;
    }

    let image_format_properties = unsafe {
        vki.get_physical_device_image_format_properties(
            phys_device,
            info.format,
            info.image_type,
            info.tiling,
            info.usage,
            info.flags,
        )
    };

    match image_format_properties {
        Ok(properties) => {
            if info.array_layers > properties.max_array_layers {
                return false;
            }
            if info.mip_levels > properties.max_mip_levels {
                return false;
            }
            if !properties.sample_counts.intersects(info.samples) {
                return false;
            }
        }
        Err(_) => return false,
    }

    !(info.flags.contains(vk::ImageCreateFlags::SPARSE_BINDING) && !check_sparse_image_format_support(context, info))
}

/// `makeExtentForImage`
fn make_extent_for_image(image_type: vk::ImageType) -> vk::Extent3D {
    let mut extent = vk::Extent3D {
        width: 64,
        height: 64,
        depth: 4,
    };

    if image_type == vk::ImageType::_1D {
        extent.height = 1;
        extent.depth = 1;
    } else if image_type == vk::ImageType::_2D {
        extent.depth = 1;
    }

    extent
}

/// `halfExtentForImage`
fn half_extent_for_image(image_type: vk::ImageType, extent: vk::Extent3D) -> vk::Extent3D {
    let mut half_extent = extent;

    if image_type == vk::ImageType::_1D {
        half_extent.width /= 2;
    } else if image_type == vk::ImageType::_2D {
        half_extent.height /= 2;
    } else {
        half_extent.depth /= 2;
    }

    half_extent
}

/// `isFormatMatchingAspect`
fn is_format_matching_aspect(format: vk::Format, aspect: vk::ImageAspectFlags) -> bool {
    // D/S formats are laid out next to each other in the enum
    let is_depth_stencil = is_depth_stencil_format(format);

    (aspect == (vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)) == is_depth_stencil
}

/// `getImageInfoString`
fn get_image_info_string(image_info: &vk::ImageCreateInfo) -> String {
    let mut s = String::new();

    s.push_str(match image_info.image_type {
        vk::ImageType::_1D => "1D ",
        vk::ImageType::_2D => "2D ",
        vk::ImageType::_3D => "3D ",
        _ => "",
    });

    s.push_str(match image_info.tiling {
        vk::ImageTiling::OPTIMAL => "(optimal) ",
        vk::ImageTiling::LINEAR => "(linear) ",
        _ => "",
    });

    s.push_str(&format!(
        "extent:[{}, {}, {}] {} samples:{} flags:{} usage:{} ",
        image_info.extent.width,
        image_info.extent.height,
        image_info.extent.depth,
        image_info.format.as_raw(),
        image_info.samples.bits(),
        image_info.flags.bits(),
        image_info.usage.bits()
    ));

    s
}

/// `checkSupportImageMemoryRequirementsOriginal`
fn check_support_image_memory_requirements_original(
    context: &Context<'_>,
    params: ImageTestParams,
) -> Result<(), TestError> {
    let features = context.get_device_features();

    if params.flags.contains(vk::ImageCreateFlags::SPARSE_BINDING) && features.sparse_binding == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: sparseBinding".to_string(),
        ));
    }

    if params.flags.contains(vk::ImageCreateFlags::SPARSE_ALIASED) && features.sparse_residency_aliased == vk::FALSE {
        return Err(TestError::NotSupported(
            "Feature not supported: sparseResidencyAliased".to_string(),
        ));
    }

    if params.flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY)
        && features.sparse_residency_image_2d == vk::FALSE
        && features.sparse_residency_image_3d == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Feature not supported: sparseResidencyImage (2D and 3D)".to_string(),
        ));
    }

    Ok(())
}

/// `checkSupportImageMemoryRequirementsExtended`
fn check_support_image_memory_requirements_extended(
    context: &Context<'_>,
    params: ImageTestParams,
) -> Result<(), TestError> {
    check_support_image_memory_requirements_original(context, params)?;
    require_promoted_to_1_1(context, "VK_KHR_get_memory_requirements2")
}

/// `ImageMemoryRequirements*`'s data members, the whole hierarchy's at once.
struct ImageMemoryRequirements {
    variant: ImageVariant,
    current_test_image_info: vk::ImageCreateInfo,
    current_test_requirements: vk::MemoryRequirements,
    current_test_sparse_requirements: Vec<vk::SparseImageMemoryRequirements>,

    current_test_prefers_dedicated_allocation: vk::Bool32,
    current_test_requires_dedicated_allocation: vk::Bool32,

    current_test_original_requirements: vk::MemoryRequirements,
    current_test_half_requirements: vk::MemoryRequirements,
    current_test_original_sparse_requirements: Vec<vk::SparseImageMemoryRequirements>,
}

impl ImageMemoryRequirements {
    fn new(variant: ImageVariant) -> Self {
        Self {
            variant,
            current_test_image_info: vk::ImageCreateInfo::default(),
            current_test_requirements: vk::MemoryRequirements::default(),
            current_test_sparse_requirements: Vec::new(),
            current_test_prefers_dedicated_allocation: vk::FALSE,
            current_test_requires_dedicated_allocation: vk::FALSE,
            current_test_original_requirements: vk::MemoryRequirements::default(),
            current_test_half_requirements: vk::MemoryRequirements::default(),
            current_test_original_sparse_requirements: Vec::new(),
        }
    }

    /// `ImageMemoryRequirementsOriginal::execTest`
    fn exec_test(&mut self, context: &Context<'_>, params: ImageTestParams) -> TestOutcome {
        let vki = context.get_instance();
        let phys_device = context.get_physical_device();
        let sparse_flags = SPARSE_FLAGS.bits();
        let transient_flags = vk::ImageUsageFlags::TRANSIENT_ATTACHMENT.bits();

        let memory_properties = unsafe { vki.get_physical_device_memory_properties(phys_device) };
        let not_initialized_bits = !0u32;
        let color_aspect = vk::ImageAspectFlags::COLOR;
        let depth_stencil_aspect = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let all_aspects = [color_aspect, depth_stencil_aspect];
        let mut all_pass = true;
        let mut num_checked_images = 0u32;

        log::info!("Verify memory requirements for the following parameter combinations:");

        let formats = all_formats();

        for aspect in all_aspects {
            let mut previous_memory_type_bits = not_initialized_bits;

            for &format in &formats {
                if !is_format_matching_aspect(format, aspect) {
                    continue;
                }

                // memoryTypeBits may differ between depth/stencil formats
                if aspect == depth_stencil_aspect {
                    previous_memory_type_bits = not_initialized_bits;
                }

                for loop_image_type in [vk::ImageType::_1D, vk::ImageType::_2D, vk::ImageType::_3D] {
                    let mut loop_create_flags = 0u32;
                    while loop_create_flags <= vk::ImageCreateFlags::CUBE_COMPATIBLE.bits() {
                        let mut loop_usage_flags = vk::ImageUsageFlags::TRANSFER_SRC.bits();
                        while loop_usage_flags <= vk::ImageUsageFlags::INPUT_ATTACHMENT.bits() {
                            let mut loop_sample_count = vk::SampleCountFlags::_1.bits();
                            while loop_sample_count <= vk::SampleCountFlags::_16.bits() {
                                let actual_create_flags =
                                    vk::ImageCreateFlags::from_bits_truncate(loop_create_flags) | params.flags;
                                let actual_usage_flags = vk::ImageUsageFlags::from_bits_truncate(loop_usage_flags)
                                    | if params.transient {
                                        vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
                                    } else {
                                        vk::ImageUsageFlags::empty()
                                    };
                                let is_cube = actual_create_flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE);
                                let image_info = vk::ImageCreateInfo {
                                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                                    next: std::ptr::null(),
                                    flags: actual_create_flags,
                                    image_type: loop_image_type,
                                    format,
                                    extent: make_extent_for_image(loop_image_type),
                                    mip_levels: 1,
                                    array_layers: if is_cube { 6 } else { 1 },
                                    samples: vk::SampleCountFlags::from_bits_truncate(loop_sample_count),
                                    tiling: params.tiling,
                                    usage: actual_usage_flags,
                                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                                    queue_family_index_count: 0,
                                    queue_family_indices: std::ptr::null(),
                                    initial_layout: vk::ImageLayout::UNDEFINED,
                                };

                                self.current_test_image_info = image_info;
                                loop_sample_count = next_flag(loop_sample_count);

                                if !is_image_supported(context, &self.current_test_image_info) {
                                    continue;
                                }

                                log::info!("- {}", get_image_info_string(&self.current_test_image_info));
                                num_checked_images += 1;

                                let mut result = ResultCollector::new("ERROR: ");

                                self.update_memory_requirements(context)?;

                                self.verify_memory_requirements(&mut result, &memory_properties);

                                // For the same tiling, transient usage, and sparse flags, (and format, if D/S) memoryTypeBits must be the same for all images
                                result.check(
                                    previous_memory_type_bits == not_initialized_bits
                                        || self.current_test_requirements.memory_type_bits == previous_memory_type_bits,
                                    "memoryTypeBits differ from the ones in the previous image configuration",
                                );

                                if result.to_status().code() != TestResult::Pass {
                                    all_pass = false;
                                }

                                previous_memory_type_bits = self.current_test_requirements.memory_type_bits;
                            }
                            loop_usage_flags = next_flag_excluding(loop_usage_flags, transient_flags);
                        }
                        loop_create_flags = next_flag_excluding(loop_create_flags, sparse_flags);
                    }
                }
            }
        }

        if num_checked_images == 0 {
            log::info!("NOTE: No supported image configurations -- nothing to check");
        }

        Ok(if all_pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Some memory requirements were incorrect")
        })
    }

    /// `updateMemoryRequirements` - the override of each variant.
    fn update_memory_requirements(&mut self, context: &Context<'_>) -> Result<(), TestError> {
        let vk = context.get_device();
        match self.variant {
            ImageVariant::Original => {
                let raw_image =
                    unsafe { vk.create_image(&self.current_test_image_info, None) }.vk_check("vkCreateImage")?;
                let image = Unique::new(vk, raw_image);

                self.current_test_requirements = unsafe { vk.get_image_memory_requirements(*image) };

                if self
                    .current_test_image_info
                    .flags
                    .contains(vk::ImageCreateFlags::SPARSE_BINDING)
                {
                    self.current_test_sparse_requirements = unsafe { vk.get_image_sparse_memory_requirements(*image) };
                }
            }
            ImageVariant::Extended => {
                self.current_test_requirements =
                    get_image_memory_requirements2(vk, &self.current_test_image_info, None)?;
            }
            ImageVariant::DedicatedAllocation => {
                let invalid_vk_bool32: u32 = !0;

                let mut dedicated_requirements = vk::MemoryDedicatedRequirements {
                    s_type: vk::StructureType::MEMORY_DEDICATED_REQUIREMENTS,
                    next: std::ptr::null_mut(),
                    prefers_dedicated_allocation: invalid_vk_bool32,
                    requires_dedicated_allocation: invalid_vk_bool32,
                };

                self.current_test_requirements = get_image_memory_requirements2(
                    vk,
                    &self.current_test_image_info,
                    Some(&mut dedicated_requirements),
                )?;
                self.current_test_prefers_dedicated_allocation = dedicated_requirements.prefers_dedicated_allocation;
                self.current_test_requires_dedicated_allocation = dedicated_requirements.requires_dedicated_allocation;
            }
            ImageVariant::CreateInfo => {
                self.current_test_requirements =
                    get_device_image_memory_requirements(context, &self.current_test_image_info);

                let raw_image =
                    unsafe { vk.create_image(&self.current_test_image_info, None) }.vk_check("vkCreateImage")?;
                let image = Unique::new(vk, raw_image);
                self.current_test_original_requirements = unsafe { vk.get_image_memory_requirements(*image) };

                let half_image_create_info = vk::ImageCreateInfo {
                    extent: half_extent_for_image(
                        self.current_test_image_info.image_type,
                        self.current_test_image_info.extent,
                    ),
                    ..self.current_test_image_info
                };
                self.current_test_half_requirements =
                    get_device_image_memory_requirements(context, &half_image_create_info);

                if self
                    .current_test_image_info
                    .flags
                    .contains(vk::ImageCreateFlags::SPARSE_BINDING)
                {
                    self.current_test_sparse_requirements =
                        get_image_create_info_sparse_memory_requirements(context, &self.current_test_image_info);
                    self.current_test_original_sparse_requirements =
                        unsafe { vk.get_image_sparse_memory_requirements(*image) };
                }
            }
        }
        Ok(())
    }

    /// `verifyMemoryRequirements` - the override of each variant, each one running its base's first.
    fn verify_memory_requirements(
        &self,
        result: &mut ResultCollector,
        device_memory_properties: &vk::PhysicalDeviceMemoryProperties,
    ) {
        self.verify_original(result, device_memory_properties);

        match self.variant {
            ImageVariant::Original | ImageVariant::Extended => {}
            ImageVariant::DedicatedAllocation => {
                result.check(
                    valid_value_vk_bool32(self.current_test_prefers_dedicated_allocation),
                    "Non-bool value in m_currentTestPrefersDedicatedAllocation",
                );

                result.check(
                    self.current_test_requires_dedicated_allocation == vk::FALSE,
                    "Test design expects m_currentTestRequiresDedicatedAllocation to be false",
                );
            }
            ImageVariant::CreateInfo => self.verify_create_info(result),
        }
    }

    /// `ImageMemoryRequirementsOriginal::verifyMemoryRequirements`
    fn verify_original(
        &self,
        result: &mut ResultCollector,
        device_memory_properties: &vk::PhysicalDeviceMemoryProperties,
    ) {
        if !result.check(
            self.current_test_requirements.memory_type_bits != 0,
            "VkMemoryRequirements memoryTypeBits has no bits set",
        ) {
            return;
        }

        let used_memory_type_indices = bits_to_indices(self.current_test_requirements.memory_type_bits);
        let mut device_local_memory_found = false;
        let mut host_visible_coherent_memory_found = false;

        for &memory_type_ndx in &used_memory_type_indices {
            if memory_type_ndx >= device_memory_properties.memory_type_count {
                result.fail("VkMemoryRequirements memoryTypeBits contains bits for non-existing memory types");
                continue;
            }

            let memory_property_flags = device_memory_properties.memory_types[memory_type_ndx as usize].property_flags;

            if memory_property_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
                device_local_memory_found = true;
            }

            if memory_property_flags
                .intersects(vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT)
            {
                host_visible_coherent_memory_found = true;
            }

            if memory_property_flags.contains(vk::MemoryPropertyFlags::LAZILY_ALLOCATED) {
                result.check(
                    self.current_test_image_info
                        .usage
                        .contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT),
                    "Memory type includes VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT for a non-transient attachment image",
                );
            }
        }

        result.check(
            self.current_test_requirements.alignment.is_power_of_two(),
            "VkMemoryRequirements alignment isn't power of two",
        );

        result.check(
            device_local_memory_found,
            "None of the required memory types included VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT",
        );

        result.check(
            self.current_test_image_info.tiling == vk::ImageTiling::OPTIMAL || host_visible_coherent_memory_found,
            "Required memory type doesn't include VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT and VK_MEMORY_PROPERTY_HOST_COHERENT_BIT",
        );

        if self
            .current_test_image_info
            .flags
            .contains(vk::ImageCreateFlags::SPARSE_BINDING)
        {
            for sparse_requirements in &self.current_test_sparse_requirements {
                result.check(
                    sparse_requirements.image_mip_tail_size % self.current_test_requirements.alignment == 0,
                    "VkSparseImageMemoryRequirements imageMipTailSize is not aligned with sparse block size",
                );
            }
        }
    }

    /// `ImageMemoryRequirementsCreateInfo::verifyMemoryRequirements`, past its base's checks.
    fn verify_create_info(&self, result: &mut ResultCollector) {
        result.check(
            self.current_test_requirements.alignment == self.current_test_original_requirements.alignment,
            "VkMemoryRequirements alignment queried from vkImageCreateInfo differs from equivalent object query",
        );

        result.check(
            self.current_test_requirements.memory_type_bits == self.current_test_original_requirements.memory_type_bits,
            "VkMemoryRequirements memoryTypeBits queried from vkImageCreateInfo differs from equivalent object query",
        );

        result.check(
            self.current_test_requirements.size == self.current_test_original_requirements.size,
            "VkMemoryRequirements size queried from vkImageCreateInfo differs from equivalent object query",
        );

        result.check(
            self.current_test_requirements.size >= self.current_test_half_requirements.size,
            "VkMemoryRequirements size queried from vkImageCreateInfo is larger for a smaller image",
        );

        if !self
            .current_test_image_info
            .flags
            .contains(vk::ImageCreateFlags::SPARSE_BINDING)
        {
            return;
        }

        result.check(
            self.current_test_sparse_requirements.len() == self.current_test_original_sparse_requirements.len(),
            "VkSparseImageMemoryRequirements count queried from vkImageCreateInfo differs from equivalent object query",
        );

        // Upstream indexes the object-side vector by the create-info side's index; a count
        // mismatch has been recorded as a failure above, so stop at the shorter one.
        for (from_create_info, from_object) in self
            .current_test_sparse_requirements
            .iter()
            .zip(&self.current_test_original_sparse_requirements)
        {
            result.check(
                from_create_info.format_properties.aspect_mask == from_object.format_properties.aspect_mask,
                "VkSparseImageMemoryRequirements aspectMask queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.format_properties.flags == from_object.format_properties.flags,
                "VkSparseImageMemoryRequirements flags queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.format_properties.image_granularity.width == from_object.format_properties.image_granularity.width,
                "VkSparseImageMemoryRequirements imageGranularity queried from vkImageCreateInfo differs from equivalent object query",
            );
            result.check(
                from_create_info.format_properties.image_granularity.height == from_object.format_properties.image_granularity.height,
                "VkSparseImageMemoryRequirements imageGranularity queried from vkImageCreateInfo differs from equivalent object query",
            );
            result.check(
                from_create_info.format_properties.image_granularity.depth == from_object.format_properties.image_granularity.depth,
                "VkSparseImageMemoryRequirements imageGranularity queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.image_mip_tail_first_lod == from_object.image_mip_tail_first_lod,
                "VkSparseImageMemoryRequirements imageMipTailFirstLod queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.image_mip_tail_size == from_object.image_mip_tail_size,
                "VkSparseImageMemoryRequirements imageMipTailSize queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.image_mip_tail_offset == from_object.image_mip_tail_offset,
                "VkSparseImageMemoryRequirements imageMipTailOffset queried from vkImageCreateInfo differs from equivalent object query",
            );

            result.check(
                from_create_info.image_mip_tail_stride == from_object.image_mip_tail_stride,
                "VkSparseImageMemoryRequirements imageMipTailStride queried from vkImageCreateInfo differs from equivalent object query",
            );
        }
    }
}

struct ImageRequirementsCase {
    name: String,
    variant: ImageVariant,
    params: ImageTestParams,
}

impl TestCase for ImageRequirementsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            ImageVariant::Original => check_support_image_memory_requirements_original(context, self.params),
            ImageVariant::Extended => check_support_image_memory_requirements_extended(context, self.params),
            ImageVariant::DedicatedAllocation => {
                check_support_image_memory_requirements_extended(context, self.params)?;
                require_promoted_to_1_1(context, "VK_KHR_dedicated_allocation")
            }
            ImageVariant::CreateInfo => {
                check_support_image_memory_requirements_extended(context, self.params)?;
                context.require_device_functionality("VK_KHR_maintenance4")
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageRequirementsInstance {
            context,
            variant: self.variant,
            params: self.params,
        })
    }
}

struct ImageRequirementsInstance<'a> {
    context: &'a Context<'a>,
    variant: ImageVariant,
    params: ImageTestParams,
}

impl TestInstance for ImageRequirementsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut test = ImageMemoryRequirements::new(self.variant);
        test.exec_test(self.context, self.params)
    }
}

/// `ImageMemoryRequirements*::populateTestGroup`
pub fn populate_image_test_group(group: &mut TestCaseGroup, variant: ImageVariant) {
    let image_flags_cases: [(vk::ImageCreateFlags, bool, &str); 6] = [
        (vk::ImageCreateFlags::empty(), false, "regular"),
        (vk::ImageCreateFlags::empty(), true, "transient"),
        (vk::ImageCreateFlags::SPARSE_BINDING, false, "sparse"),
        (
            vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY,
            false,
            "sparse_residency",
        ),
        (
            vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_ALIASED,
            false,
            "sparse_aliased",
        ),
        (
            vk::ImageCreateFlags::SPARSE_BINDING
                | vk::ImageCreateFlags::SPARSE_RESIDENCY
                | vk::ImageCreateFlags::SPARSE_ALIASED,
            false,
            "sparse_residency_aliased",
        ),
    ];

    let mut image_group = TestCaseGroup::new("image");

    for (flags, transient, name) in image_flags_cases {
        for tiling_ndx in 0..=1 {
            let (tiling, suffix) = if tiling_ndx != 0 {
                (vk::ImageTiling::OPTIMAL, "_tiling_optimal")
            } else {
                (vk::ImageTiling::LINEAR, "_tiling_linear")
            };

            if flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY) && tiling == vk::ImageTiling::LINEAR {
                continue;
            }

            image_group.add_child(Box::new(ImageRequirementsCase {
                name: format!("{name}{suffix}"),
                variant,
                params: ImageTestParams {
                    flags,
                    tiling,
                    transient,
                    use_maint4: false,
                },
            }) as Box<dyn TestCase>);
        }
    }

    group.add_child(image_group);
}

/// `isMultiplaneImageSupported`
fn is_multiplane_image_supported(context: &Context<'_>, info: &vk::ImageCreateInfo) -> bool {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    // cubemap requires arrayLayers > 1, which multiplane doesn't support
    if info.flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE) {
        return false;
    }

    if info.usage.contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT)
        && !info.usage.intersects(
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        )
    {
        return false;
    }

    // VUID-VkImageCreateInfo-flags-02565
    if info.flags.contains(IMAGE_CREATE_SUBSAMPLED) && info.tiling == vk::ImageTiling::LINEAR {
        return false;
    }

    let features = unsafe { vki.get_physical_device_features(physical_device) };

    if info.flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY)
        && info.image_type == vk::ImageType::_2D
        && features.sparse_residency_image_2d == vk::FALSE
    {
        return false;
    }

    let format_properties = unsafe { vki.get_physical_device_format_properties(physical_device, info.format) };
    let format_features = if info.tiling == vk::ImageTiling::LINEAR {
        format_properties.linear_tiling_features
    } else {
        format_properties.optimal_tiling_features
    };
    if info.flags.contains(vk::ImageCreateFlags::DISJOINT)
        && !format_features.contains(vk::FormatFeatureFlags::DISJOINT)
    {
        return false;
    }

    if !does_usage_satisfy_features(info.usage, format_features) {
        return false;
    }

    let image_format_properties = unsafe {
        vki.get_physical_device_image_format_properties(
            physical_device,
            info.format,
            info.image_type,
            info.tiling,
            info.usage,
            info.flags,
        )
    };

    match image_format_properties {
        Ok(properties) => {
            if info.array_layers > properties.max_array_layers {
                return false;
            }
            if info.mip_levels > properties.max_mip_levels {
                return false;
            }
            if !properties.sample_counts.intersects(info.samples) {
                return false;
            }
            true
        }
        Err(_) => false,
    }
}

// The image create flags below come from extensions this crate's flag set may not name; the raw bits are what the spec fixes.
const IMAGE_CREATE_SAMPLE_LOCATIONS_COMPATIBLE_DEPTH: vk::ImageCreateFlags =
    vk::ImageCreateFlags::from_bits_truncate(0x1000);
const IMAGE_CREATE_CORNER_SAMPLED: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x2000);
const IMAGE_CREATE_SUBSAMPLED: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x4000);
const IMAGE_CREATE_FRAGMENT_DENSITY_MAP_OFFSET_QCOM: vk::ImageCreateFlags =
    vk::ImageCreateFlags::from_bits_truncate(0x8000);
const IMAGE_CREATE_2D_VIEW_COMPATIBLE: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x20000);
const IMAGE_CREATE_MULTISAMPLED_RENDER_TO_SINGLE_SAMPLED: vk::ImageCreateFlags =
    vk::ImageCreateFlags::from_bits_truncate(0x40000);
const IMAGE_CREATE_2D_ARRAY_COMPATIBLE: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x20);
const IMAGE_CREATE_ALIAS: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x400);
const IMAGE_CREATE_EXTENDED_USAGE: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x100);
const IMAGE_CREATE_DISJOINT: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x200);
const IMAGE_CREATE_PROTECTED: vk::ImageCreateFlags = vk::ImageCreateFlags::from_bits_truncate(0x800);

/// `context.getDeviceVulkan11Features().protectedMemory`; the device is created with everything the
/// physical device advertises, so the physical device's answer is the device's.
fn is_protected_memory_enabled(context: &Context<'_>) -> bool {
    let mut protected_memory = vk::PhysicalDeviceProtectedMemoryFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    features2.next = (&raw mut protected_memory).cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    protected_memory.protected_memory != vk::FALSE
}

/// `isMultisampledRenderToSingleSampledEnabled`
fn is_multisampled_render_to_single_sampled_enabled(context: &Context<'_>) -> bool {
    if !context.is_device_functionality_supported("VK_EXT_multisampled_render_to_single_sampled") {
        return false;
    }

    let mut feature = vk::PhysicalDeviceMultisampledRenderToSingleSampledFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    features2.next = (&raw mut feature).cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    feature.multisampled_render_to_single_sampled != vk::FALSE
}

/// `checkSupportMultiplane`
fn check_support_multiplane(context: &Context<'_>, params: ImageTestParams) -> Result<(), TestError> {
    check_support_image_memory_requirements_original(context, params)?;

    require_promoted_to_1_1(context, "VK_KHR_get_memory_requirements2")?;
    context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;

    if params.use_maint4 {
        context.require_device_functionality("VK_KHR_maintenance4")?;
    }
    Ok(())
}

/// `testMultiplaneImages`
fn test_multiplane_images(context: &Context<'_>, params: ImageTestParams) -> TestOutcome {
    let mut non_sparse_create_flags: Vec<vk::ImageCreateFlags> = vec![
        vk::ImageCreateFlags::MUTABLE_FORMAT,
        vk::ImageCreateFlags::CUBE_COMPATIBLE,
        IMAGE_CREATE_ALIAS,
        // VK_IMAGE_CREATE_SPLIT_INSTANCE_BIND_REGIONS_BIT - present tests use only one physical device
        IMAGE_CREATE_2D_ARRAY_COMPATIBLE,
        // VK_IMAGE_CREATE_BLOCK_TEXEL_VIEW_COMPATIBLE_BIT not apply with planar formats
        IMAGE_CREATE_EXTENDED_USAGE,
        IMAGE_CREATE_DISJOINT,
        IMAGE_CREATE_SAMPLE_LOCATIONS_COMPATIBLE_DEPTH,
    ];
    if is_protected_memory_enabled(context) {
        non_sparse_create_flags.push(IMAGE_CREATE_PROTECTED);
    }
    if context.is_device_functionality_supported("VK_NV_corner_sampled_image") {
        non_sparse_create_flags.push(IMAGE_CREATE_CORNER_SAMPLED);
    }
    if context.is_device_functionality_supported("VK_EXT_fragment_density_map") {
        non_sparse_create_flags.push(IMAGE_CREATE_SUBSAMPLED);
    }
    if context.is_device_functionality_supported("VK_EXT_image_2d_view_of_3d") {
        non_sparse_create_flags.push(IMAGE_CREATE_2D_VIEW_COMPATIBLE);
    }
    if context.is_device_functionality_supported("VK_QCOM_fragment_density_map_offset") {
        non_sparse_create_flags.push(IMAGE_CREATE_FRAGMENT_DENSITY_MAP_OFFSET_QCOM);
    }
    if is_multisampled_render_to_single_sampled_enabled(context) {
        non_sparse_create_flags.push(IMAGE_CREATE_MULTISAMPLED_RENDER_TO_SINGLE_SAMPLED);
    }

    let sparse_create_flags: Vec<vk::ImageCreateFlags> = vec![
        vk::ImageCreateFlags::SPARSE_BINDING,
        vk::ImageCreateFlags::SPARSE_RESIDENCY,
        vk::ImageCreateFlags::SPARSE_ALIASED,
        vk::ImageCreateFlags::MUTABLE_FORMAT,
    ];

    let is_sparse_test = params.flags.contains(vk::ImageCreateFlags::SPARSE_BINDING);
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let vk = context.get_device();
    let transient_flags = vk::ImageUsageFlags::TRANSIENT_ATTACHMENT.bits();
    let memory_properties = unsafe { vki.get_physical_device_memory_properties(physical_device) };
    let mut result = ResultCollector::new("ERROR: ");
    let mut supported_formats: Vec<vk::Format> = Vec::new();

    log::info!(
        "Memory properties: {} types, {} heaps",
        memory_properties.memory_type_count,
        memory_properties.memory_heap_count
    );

    for format in planar_formats() {
        let create_flags_list = if is_sparse_test {
            &sparse_create_flags
        } else {
            &non_sparse_create_flags
        };
        for &loop_create_flags in create_flags_list {
            let image_type = if loop_create_flags.contains(IMAGE_CREATE_2D_ARRAY_COMPATIBLE)
                || loop_create_flags.contains(IMAGE_CREATE_2D_VIEW_COMPATIBLE)
            {
                if is_ycbcr_conversion_format(format) {
                    // VK_IMAGE_TYPE_MAX_ENUM
                    continue;
                }
                vk::ImageType::_3D
            } else {
                vk::ImageType::_2D
            };

            if loop_create_flags.contains(IMAGE_CREATE_SAMPLE_LOCATIONS_COMPATIBLE_DEPTH)
                && !is_depth_stencil_format(format)
            {
                continue;
            }

            let mut loop_usage_flags = vk::ImageUsageFlags::TRANSFER_SRC.bits();
            while loop_usage_flags <= vk::ImageUsageFlags::INPUT_ATTACHMENT.bits() {
                let current_usage_flags = loop_usage_flags;
                loop_usage_flags = next_flag_excluding(loop_usage_flags, transient_flags);

                let actual_create_flags = loop_create_flags
                    | if is_sparse_test {
                        params.flags
                    } else {
                        vk::ImageCreateFlags::empty()
                    };
                let actual_usage_flags = vk::ImageUsageFlags::from_bits_truncate(current_usage_flags)
                    | if params.transient {
                        vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
                    } else {
                        vk::ImageUsageFlags::empty()
                    };
                let array_layers = if image_type == vk::ImageType::_2D
                    && loop_create_flags.contains(vk::ImageCreateFlags::CUBE_COMPATIBLE)
                {
                    6
                } else {
                    1
                };
                let image_info = vk::ImageCreateInfo {
                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: actual_create_flags,
                    image_type,
                    format,
                    extent: vk::Extent3D {
                        width: 64,
                        height: 64,
                        depth: 1,
                    },
                    mip_levels: 1,
                    array_layers,
                    samples: vk::SampleCountFlags::_1,
                    tiling: params.tiling,
                    usage: actual_usage_flags,
                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                    queue_family_index_count: 0,
                    queue_family_indices: std::ptr::null(),
                    initial_layout: vk::ImageLayout::UNDEFINED,
                };

                if !is_multiplane_image_supported(context, &image_info) {
                    continue;
                }

                let image = if params.use_maint4 {
                    None
                } else {
                    let raw_image = unsafe { vk.create_image(&image_info, None) }.vk_check("vkCreateImage")?;
                    Some(Unique::new(vk, raw_image))
                };

                log::info!("- {}", get_image_info_string(&image_info));

                if !supported_formats.contains(&format) {
                    supported_formats.push(format);
                }

                for plane_ndx in 0..get_plane_count(format) {
                    let aspect = plane_aspect(plane_ndx);
                    let mut requirements = vk::MemoryRequirements2::default();

                    if params.use_maint4 {
                        let info = vk::DeviceImageMemoryRequirements {
                            s_type: vk::StructureType::DEVICE_IMAGE_MEMORY_REQUIREMENTS,
                            next: std::ptr::null(),
                            create_info: &image_info,
                            plane_aspect: aspect,
                        };
                        if context.api_version() >= (1, 3, 0) {
                            unsafe { vk.get_device_image_memory_requirements(&info, &mut requirements) };
                        } else {
                            unsafe { vk.get_device_image_memory_requirements_khr(&info, &mut requirements) };
                        }
                    } else {
                        let aspect_info = vk::ImagePlaneMemoryRequirementsInfo {
                            s_type: vk::StructureType::IMAGE_PLANE_MEMORY_REQUIREMENTS_INFO,
                            next: std::ptr::null(),
                            plane_aspect: aspect,
                        };
                        let info = vk::ImageMemoryRequirementsInfo2 {
                            s_type: vk::StructureType::IMAGE_MEMORY_REQUIREMENTS_INFO_2,
                            next: if actual_create_flags.contains(vk::ImageCreateFlags::DISJOINT) {
                                (&raw const aspect_info).cast()
                            } else {
                                std::ptr::null()
                            },
                            image: **image
                                .as_ref()
                                .expect("an image is created unless maintenance4 is in use"),
                        };

                        unsafe { vk.get_image_memory_requirements2(&info, &mut requirements) };
                    }

                    log::info!(
                        "Aspect: {:?}, Requirements: {:?}",
                        aspect,
                        requirements.memory_requirements
                    );

                    result.check(
                        requirements.memory_requirements.alignment.is_power_of_two(),
                        "VkMemoryRequirements alignment isn't power of two",
                    );

                    if actual_create_flags.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY) {
                        let sparse_requirements = match &image {
                            Some(image) if !params.use_maint4 => unsafe {
                                vk.get_image_sparse_memory_requirements(**image)
                            },
                            _ => get_device_image_sparse_memory_requirements(context, &image_info, aspect),
                        };

                        for sr in &sparse_requirements {
                            if sr.format_properties.aspect_mask == aspect {
                                result.check(
                                    sr.image_mip_tail_size % requirements.memory_requirements.alignment == 0,
                                    "VkSparseImageMemoryRequirements::imageMipTailSize is not aligned with sparse block size",
                                );
                                break;
                            }
                        }
                    }

                    if result.check(
                        requirements.memory_requirements.memory_type_bits != 0,
                        "No supported memory types",
                    ) {
                        let used_memory_type_indices =
                            bits_to_indices(requirements.memory_requirements.memory_type_bits);
                        let mut has_host_visible_type = false;

                        for &memory_type_ndx in &used_memory_type_indices {
                            if result.check(
                                memory_type_ndx < memory_properties.memory_type_count,
                                "Unknown memory type bits set in memory requirements",
                            ) {
                                let property_flags =
                                    memory_properties.memory_types[memory_type_ndx as usize].property_flags;

                                if property_flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE) {
                                    has_host_visible_type = true;
                                }

                                if property_flags.contains(vk::MemoryPropertyFlags::LAZILY_ALLOCATED) {
                                    result.check(
                                        image_info.usage.contains(vk::ImageUsageFlags::TRANSIENT_ATTACHMENT),
                                        "Memory type includes VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT for a non-transient attachment image",
                                    );
                                }
                            } else {
                                break;
                            }
                        }

                        result.check(
                            params.tiling != vk::ImageTiling::LINEAR
                                || has_host_visible_type
                                || loop_create_flags.contains(IMAGE_CREATE_PROTECTED),
                            "Required memory type doesn't include VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT",
                        );
                    }
                }
            }
        }
    }

    if supported_formats.is_empty() {
        return Ok(TestStatus::new(
            TestResult::NotSupported,
            "None of tested in given configuration multiplanar formats is supported by device.",
        ));
    }

    Ok(result.to_status())
}

struct MultiplaneCase {
    name: String,
    params: ImageTestParams,
}

impl TestCase for MultiplaneCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_multiplane(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiplaneInstance {
            context,
            params: self.params,
        })
    }
}

struct MultiplaneInstance<'a> {
    context: &'a Context<'a>,
    params: ImageTestParams,
}

impl TestInstance for MultiplaneInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_multiplane_images(self.context, self.params)
    }
}

/// `populateMultiplaneTestGroup`
pub fn populate_multiplane_test_group(group: &mut TestCaseGroup, use_maint4: bool) {
    let image_flags_cases: [(vk::ImageCreateFlags, bool, &str); 6] = [
        (vk::ImageCreateFlags::empty(), false, "regular"),
        (vk::ImageCreateFlags::empty(), true, "transient"),
        (vk::ImageCreateFlags::SPARSE_BINDING, false, "sparse"),
        (
            vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY,
            false,
            "sparse_residency",
        ),
        (
            vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_ALIASED,
            false,
            "sparse_aliased",
        ),
        (
            vk::ImageCreateFlags::SPARSE_BINDING
                | vk::ImageCreateFlags::SPARSE_RESIDENCY
                | vk::ImageCreateFlags::SPARSE_ALIASED,
            false,
            "sparse_residency_aliased",
        ),
    ];
    let tilings: [(vk::ImageTiling, &str); 2] = [
        (vk::ImageTiling::OPTIMAL, "optimal"),
        (vk::ImageTiling::LINEAR, "linear"),
    ];

    for (flags, transient, flags_name) in image_flags_cases {
        for (tiling, tiling_name) in tilings {
            if tiling == vk::ImageTiling::LINEAR && flags.contains(vk::ImageCreateFlags::SPARSE_BINDING) {
                continue;
            }

            group.add_child(Box::new(MultiplaneCase {
                name: format!("{flags_name}_{tiling_name}"),
                params: ImageTestParams {
                    flags,
                    tiling,
                    transient,
                    use_maint4,
                },
            }) as Box<dyn TestCase>);
        }
    }
}
