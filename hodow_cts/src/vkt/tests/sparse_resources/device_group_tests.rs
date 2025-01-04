// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageSparseBinding.cpp
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageSparseResidency.cpp
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageMemoryAliasing.cpp
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesMipmapSparseResidency.cpp
//   (the `createDeviceGroup*Tests` of each)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The four `device_group_*` trees are the trees of the plain groups with the case registered for a logical device created from a
// device group. Upstream's `createDeviceSupportingQueues` refuses a group of fewer than two physical devices with NotSupported
// ("Sparse binding device group tests not supported with 1 physical device"), which is what every one of these cases reports on
// a machine with a single GPU. A group of two or more is not exercised: the peer-memory and per-device bind paths are not ported,
// so those cases report NotPorted instead of a verdict nobody earned.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::tests_util::{
    ImageType, TestImageParameters, get_image_format_id, get_image_size_alignment, get_image_type_name,
    get_test_formats,
};
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `m_useDeviceGroups` branch of `createDeviceSupportingQueues`: the default device group has to hold at least two physical
/// devices, and what a group that does is made to do is not ported.
pub(super) fn device_group_unavailable(context: &Context<'_>) -> TestError {
    let groups = match unsafe { context.get_instance().enumerate_physical_device_groups() }
        .vk_check("vkEnumeratePhysicalDeviceGroups")
    {
        Ok(groups) => groups,
        Err(error) => return error,
    };
    let physical_device_count = groups.first().map_or(0, |group| group.physical_device_count);
    if physical_device_count < 2 {
        TestError::NotSupported("Sparse binding device group tests not supported with 1 physical device".to_string())
    } else {
        TestError::NotPorted("sparse binding on a device group of several physical devices".to_string())
    }
}

/// The sparse features the plain case of the same family requires in `checkSupport`.
#[derive(Clone, Copy)]
enum RequiredFeatures {
    None,
    SparseBinding,
    SparseBindingAndAliased,
}

struct DeviceGroupSparseCase {
    name: String,
    required: RequiredFeatures,
}

impl TestCase for DeviceGroupSparseCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if !matches!(self.required, RequiredFeatures::None) && features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        if matches!(self.required, RequiredFeatures::SparseBindingAndAliased)
            && features.sparse_residency_aliased == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "sparseResidencyAliased not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DeviceGroupSparseInstance { context })
    }
}

struct DeviceGroupSparseInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for DeviceGroupSparseInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        Err(device_group_unavailable(self.context))
    }
}

/// The `imageType / format / size` levels every one of the four trees has: a size whose x or y does not suit a subsampled YCbCr
/// format is left out.
fn add_image_type_groups(parent: &mut TestCaseGroup, image_parameters: &[TestImageParameters]) {
    for parameters in image_parameters {
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(parameters.image_type));

        for &format in &parameters.formats {
            let image_size_alignment = get_image_size_alignment(format);
            let mut format_group = TestCaseGroup::new(get_image_format_id(format));

            for &image_size in &parameters.image_sizes {
                if image_size[0] % image_size_alignment[0] != 0 || image_size[1] % image_size_alignment[1] != 0 {
                    continue;
                }
                let name = format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]);
                format_group.add_child(Box::new(DeviceGroupSparseCase {
                    name,
                    required: RequiredFeatures::None,
                }) as Box<dyn TestCase>);
            }
            image_type_group.add_child(format_group);
        }
        parent.add_child(image_type_group);
    }
}

/// `createDeviceGroupImageSparseBindingTests` - three bind types over seven image types, with the two 256-bit formats and without
/// the A8_UNORM one that only the plain group has.
pub fn create_device_group_image_sparse_binding_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("device_group_image_sparse_binding");

    let formats = |image_type: ImageType| -> Vec<vk::Format> {
        let mut formats = get_test_formats(image_type);
        formats.push(vk::Format::R64G64B64A64_UINT);
        formats.push(vk::Format::R64G64B64A64_SINT);
        formats
    };
    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::OneD,
            vec![[512, 1, 1], [1024, 1, 1], [11, 1, 1]],
            formats(ImageType::OneD),
        ),
        TestImageParameters::new(
            ImageType::OneDArray,
            vec![[512, 1, 64], [1024, 1, 8], [11, 1, 3]],
            formats(ImageType::OneDArray),
        ),
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
            formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            formats(ImageType::ThreeD),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
            formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
            formats(ImageType::CubeArray),
        ),
    ];

    for bind_type in [
        "multiple_sparse_memory_bind",
        "multiple_sparse_image_opaque_memory_bind_info",
        "multiple_bind_sparse_info",
    ] {
        let mut bind_type_group = TestCaseGroup::new(bind_type);
        add_image_type_groups(&mut bind_type_group, &image_parameters);
        test_group.add_child(bind_type_group);
    }

    test_group
}

/// `createDeviceGroupImageSparseResidencyTests` - the plain residency group's sizes with every test format, and no `mutable` group.
pub fn create_device_group_image_sparse_residency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("device_group_image_sparse_residency");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
            get_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[512, 256, 16], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];
    add_image_type_groups(&mut test_group, &image_parameters);

    test_group
}

/// `createDeviceGroupImageSparseMemoryAliasingTests`
pub fn create_device_group_image_sparse_memory_aliasing_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("device_group_image_sparse_memory_aliasing");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [128, 128, 1], [503, 137, 1], [11, 37, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [128, 128, 8], [503, 137, 3], [11, 37, 3]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1], [11, 11, 1]],
            get_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3], [11, 11, 3]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[256, 256, 16], [128, 128, 8], [503, 137, 3], [11, 37, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];
    add_image_type_groups(&mut test_group, &image_parameters);

    test_group
}

/// `createDeviceGroupMipmapSparseResidencyTests`
pub fn create_device_group_mipmap_sparse_residency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("device_group_mipmap_sparse_residency");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
            get_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
            get_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[256, 256, 16], [1024, 128, 8], [11, 137, 3]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];
    add_image_type_groups(&mut test_group, &image_parameters);

    test_group
}

/// `addBufferSparseBindingTests(group, true)`, `addBufferSparseMemoryAliasingTests(group, true)` and `addBufferSparseResidencyTests(group, true)`: the six
/// buffer sizes each of the three buffer device group trees has.
pub fn add_device_group_buffer_tests(group: &mut TestCaseGroup, kind: DeviceGroupBufferKind) {
    let required = match kind {
        DeviceGroupBufferKind::SparseBinding => RequiredFeatures::SparseBinding,
        DeviceGroupBufferKind::SparseBindingAliased => RequiredFeatures::SparseBindingAndAliased,
        DeviceGroupBufferKind::SparseResidency => RequiredFeatures::None,
    };
    for shift in [10, 12, 16, 17, 20, 24] {
        group.add_child(Box::new(DeviceGroupSparseCase {
            name: format!("buffer_size_2_{shift}"),
            required,
        }) as Box<dyn TestCase>);
    }
}

#[derive(Clone, Copy)]
pub enum DeviceGroupBufferKind {
    SparseBinding,
    SparseBindingAliased,
    SparseResidency,
}
