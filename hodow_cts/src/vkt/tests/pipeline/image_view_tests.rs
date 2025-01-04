// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImageViewTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are those of pipeline_sampler.toml (see image_sampling_instance.rs);
// `ImageViewTest::swizzle` is applied to the push constant scale and bias here as `shader_scale_bias`. The formats are generated
// by scripts/gen_pipeline_image_formats.py.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::compressed_formats::{is_astc_3d_format, is_compressed_format};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_format_lists::IMAGE_VIEW_FORMATS;
use crate::vkt::tests::pipeline::image_sampling_instance::{
    ImageSamplingInstance, ImageSamplingInstanceParams, SamplerParams, check_support_astc_format,
    check_support_image_sampling_instance, sampler_program,
};
use crate::vkt::tests::pipeline::image_util::{
    BorderColor, create_test_quad_mosaic, format_case_name, get_format_border_color, get_lookup_scale_bias,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `ImageViewTest`
struct ImageViewCase {
    name: String,
    image_view_type: vk::ImageViewType,
    image_format: vk::Format,
    sampler_lod: f32,
    component_mapping: vk::ComponentMapping,
    subresource_range: vk::ImageSubresourceRange,
    use_compute: bool,
}

/// `getRenderSize`
fn get_render_size(view_type: vk::ImageViewType) -> [u32; 2] {
    if view_type == vk::ImageViewType::_1D || view_type == vk::ImageViewType::_2D {
        [16, 16]
    } else {
        [16 * 3, 16 * 2]
    }
}

/// `getImageSize`
fn get_image_size(view_type: vk::ImageViewType) -> [i32; 3] {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => [16, 1, 1],
        vk::ImageViewType::_3D => [16, 16, 16],
        _ => [16, 16, 1],
    }
}

/// `getArraySize`
fn get_array_size(view_type: vk::ImageViewType) -> u32 {
    match view_type {
        vk::ImageViewType::_3D => 1,
        vk::ImageViewType::CUBE | vk::ImageViewType::CUBE_ARRAY => 18,
        _ => 6,
    }
}

/// `getNumLevels`
fn get_num_levels(view_type: vk::ImageViewType) -> u32 {
    let size = get_image_size(view_type);
    size[0].max(size[1].max(size[2])).ilog2() + 1
}

/// `ImageViewTest::swizzle` - indexed by the raw `VkComponentSwizzle`: identity is not a channel, zero and one are 0 and 1.
fn image_view_swizzle(input: [f32; 4], mapping: &vk::ComponentMapping) -> [f32; 4] {
    let channel_values = |swizzle: vk::ComponentSwizzle| match swizzle {
        vk::ComponentSwizzle::ZERO => 0.0,
        vk::ComponentSwizzle::ONE => 1.0,
        vk::ComponentSwizzle::R => input[0],
        vk::ComponentSwizzle::G => input[1],
        vk::ComponentSwizzle::B => input[2],
        vk::ComponentSwizzle::A => input[3],
        _ => -1.0,
    };
    [
        channel_values(mapping.r),
        channel_values(mapping.g),
        channel_values(mapping.b),
        channel_values(mapping.a),
    ]
}

impl ImageViewCase {
    /// `getImageSamplingInstanceParams`
    fn instance_params(&self) -> ImageSamplingInstanceParams {
        let view_type = self.image_view_type;
        let sampler_params = SamplerParams::default_params(
            get_format_border_color(BorderColor::TransparentBlack, self.image_format, false),
            self.subresource_range.level_count.wrapping_sub(1) as f32,
            false,
        );

        let mut params = ImageSamplingInstanceParams::new(
            get_render_size(view_type),
            view_type,
            self.image_format,
            get_image_size(view_type),
            get_array_size(view_type) as i32,
            self.component_mapping,
            self.subresource_range,
            sampler_params,
            self.sampler_lod,
            create_test_quad_mosaic(view_type),
        );
        params.use_compute = self.use_compute;
        params.explicit_lod = self.sampler_lod > 0.0;

        let (lookup_scale, lookup_bias) = get_lookup_scale_bias(self.image_format, false);
        params.shader_scale_bias = Some((
            image_view_swizzle(lookup_scale, &self.component_mapping),
            image_view_swizzle(lookup_bias, &self.component_mapping),
        ));
        params
    }
}

impl TestCase for ImageViewCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if is_astc_3d_format(self.image_format) {
            check_support_astc_format(context, self.image_format)?;
        }
        if self.use_compute && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported(
                "Exclusive compute queue not supported.".to_string(),
            ));
        }
        if self.image_format == vk::Format::A8_UNORM || self.image_format == vk::Format::A1B5G5R5_UNORM_PACK16 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        check_support_image_sampling_instance(context, &self.instance_params())
    }

    fn programs(&self) -> BinaryCollection {
        sampler_program(&self.instance_params())
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSamplingInstance::new(context, self.instance_params()))
    }
}

fn range(base_mip_level: u32, level_count: u32, base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level,
        level_count,
        base_array_layer,
        layer_count,
    }
}

/// The `TestCaseConfig`s of `createSubresourceRangeTests`, in upstream's order: mip level ranges, array ranges, both, and the
/// ranges with remaining levels and layers.
fn subresource_range_configs(view_type: vk::ImageViewType) -> Vec<(&'static str, f32, vk::ImageSubresourceRange)> {
    let num_levels = get_num_levels(view_type);
    let array_size = get_array_size(view_type);
    let remaining_levels = vk::REMAINING_MIP_LEVELS;
    let remaining_layers = vk::REMAINING_ARRAY_LAYERS;

    match view_type {
        vk::ImageViewType::_1D_ARRAY | vk::ImageViewType::_2D_ARRAY => vec![
            ("lod_base_mip_level", 0.0, range(2, num_levels - 2, 0, array_size)),
            ("lod_mip_levels", 4.0, range(0, 3, 0, array_size)),
            ("base_array_layer", 0.0, range(0, num_levels, 1, array_size - 1)),
            ("array_size", 0.0, range(0, num_levels, 0, 4)),
            ("array_base_and_size", 0.0, range(0, num_levels, 2, 3)),
            (
                "lod_base_mip_level_base_array_layer",
                0.0,
                range(2, num_levels - 2, 1, 5),
            ),
            ("lod_mip_levels_base_array_layer", 4.0, range(0, 3, 1, 5)),
            ("lod_base_mip_level_array_size", 0.0, range(2, num_levels - 2, 0, 4)),
            ("lod_mip_levels_array_size", 4.0, range(0, 3, 0, 4)),
            (
                "lod_base_mip_level_array_base_and_size",
                0.0,
                range(2, num_levels - 2, 2, 3),
            ),
            ("lod_mip_levels_array_base_and_size", 4.0, range(0, 3, 2, 3)),
            (
                "lod_base_mip_level_remaining_levels",
                0.0,
                range(1, remaining_levels, 0, array_size),
            ),
            (
                "base_array_layer_remaining_layers",
                0.0,
                range(0, num_levels, 1, remaining_layers),
            ),
            (
                "lod_base_mip_level_base_array_layer_remaining_levels_and_layers",
                0.0,
                range(2, remaining_levels, 2, remaining_layers),
            ),
        ],
        vk::ImageViewType::CUBE_ARRAY => vec![
            ("lod_base_mip_level", 0.0, range(2, num_levels - 2, 0, array_size)),
            ("lod_mip_levels", 4.0, range(0, 3, 0, array_size)),
            ("base_array_layer", 0.0, range(0, num_levels, 6, array_size - 6)),
            ("array_size", 0.0, range(0, num_levels, 0, 6)),
            ("array_base_and_size", 0.0, range(0, num_levels, 12, 6)),
            (
                "lod_base_mip_level_base_array_layer",
                0.0,
                range(2, num_levels - 2, 6, array_size - 6),
            ),
            ("lod_mip_levels_base_array_layer", 4.0, range(0, 3, 6, array_size - 6)),
            ("lod_base_mip_level_array_size", 0.0, range(2, num_levels - 2, 0, 6)),
            ("lod_mip_levels_array_size", 4.0, range(0, 3, 0, 6)),
            (
                "lod_base_mip_level_array_base_and_size",
                0.0,
                range(2, num_levels - 2, 12, 6),
            ),
            ("lod_mip_levels_array_base_and_size", 4.0, range(0, 3, 12, 6)),
            (
                "lod_base_mip_level_remaining_levels",
                0.0,
                range(1, remaining_levels, 0, array_size),
            ),
            (
                "base_array_layer_remaining_layers",
                0.0,
                range(0, num_levels, 6, remaining_layers),
            ),
            (
                "lod_base_mip_level_base_array_layer_remaining_levels_and_layers",
                0.0,
                range(2, remaining_levels, 12, remaining_layers),
            ),
        ],
        vk::ImageViewType::_1D | vk::ImageViewType::_2D => vec![
            ("lod_base_mip_level", 0.0, range(2, num_levels - 2, 0, 1)),
            ("lod_mip_levels", 4.0, range(0, 3, 0, 1)),
            ("array_layer_second", 0.0, range(0, num_levels, 1, 1)),
            ("array_layer_last", 0.0, range(0, num_levels, array_size - 1, 1)),
            (
                "lod_base_mip_level_array_layer_second",
                0.0,
                range(2, num_levels - 2, 1, 1),
            ),
            ("lod_mip_levels_array_layer_second", 4.0, range(0, 3, array_size - 1, 1)),
            (
                "lod_base_mip_level_array_layer_last",
                0.0,
                range(2, num_levels - 2, 5, 1),
            ),
            ("lod_mip_levels_array_layer_last", 4.0, range(0, 3, array_size - 1, 1)),
            (
                "lod_base_mip_level_remaining_levels",
                0.0,
                range(1, remaining_levels, 0, 1),
            ),
            (
                "array_layer_last_remaining_layers",
                0.0,
                range(0, num_levels, array_size - 1, remaining_layers),
            ),
            (
                "lod_base_mip_level_array_layer_last_remaining_levels_and_layers",
                0.0,
                range(2, remaining_levels, array_size - 1, remaining_layers),
            ),
        ],
        vk::ImageViewType::CUBE => vec![
            ("lod_base_mip_level", 0.0, range(2, num_levels - 2, 0, 6)),
            ("lod_mip_levels", 4.0, range(0, 3, 0, 6)),
            ("array_layer_second", 0.0, range(0, num_levels, 6, 6)),
            ("array_layer_last", 0.0, range(0, num_levels, array_size - 6, 6)),
            (
                "lod_base_mip_level_array_layer_second",
                0.0,
                range(2, num_levels - 2, 6, 6),
            ),
            ("lod_mip_levels_array_layer_second", 4.0, range(0, 3, 6, 6)),
            (
                "lod_base_mip_level_array_layer_last",
                0.0,
                range(2, num_levels - 2, array_size - 6, 6),
            ),
            ("lod_mip_levels_array_layer_last", 4.0, range(0, 3, array_size - 6, 6)),
            (
                "lod_base_mip_level_remaining_levels",
                0.0,
                range(1, remaining_levels, 0, 6),
            ),
            (
                "array_layer_last_remaining_layers",
                0.0,
                range(0, num_levels, array_size - 6, remaining_layers),
            ),
            (
                "lod_base_mip_level_array_layer_last_remaining_levels_and_layers",
                0.0,
                range(2, remaining_levels, array_size - 6, remaining_layers),
            ),
        ],
        _ => vec![
            ("lod_base_mip_level", 0.0, range(2, num_levels - 2, 0, array_size)),
            ("lod_mip_levels", 4.0, range(0, 3, 0, array_size)),
            (
                "lod_base_mip_level_remaining_levels",
                0.0,
                range(1, remaining_levels, 0, array_size),
            ),
            (
                "single_array_layer_remaining_layers",
                0.0,
                range(0, num_levels, 0, remaining_layers),
            ),
            (
                "lod_base_mip_level_single_array_layer_remaining_levels_and_layers",
                0.0,
                range(2, remaining_levels, 0, remaining_layers),
            ),
        ],
    }
}

const RGBA_MAPPING: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::R,
    g: vk::ComponentSwizzle::G,
    b: vk::ComponentSwizzle::B,
    a: vk::ComponentSwizzle::A,
};

/// `createSubresourceRangeTests`
fn create_subresource_range_tests(view_type: vk::ImageViewType, image_format: vk::Format) -> TestCaseGroup {
    let mut range_tests = TestCaseGroup::new("subresource_range");

    for (name, sampler_lod, subresource_range) in subresource_range_configs(view_type) {
        for (name, use_compute) in [(name.to_string(), false), (format!("{name}_compute"), true)] {
            range_tests.add_child(Box::new(ImageViewCase {
                name,
                image_view_type: view_type,
                image_format,
                sampler_lod,
                component_mapping: RGBA_MAPPING,
                subresource_range,
                use_compute,
            }) as Box<dyn TestCase>);
        }
    }

    range_tests
}

/// `getComponentSwizzleCaseName` - the name of the swizzle without the `VK_COMPONENT_SWIZZLE_` prefix, lowercased
fn component_swizzle_case_name(swizzle: vk::ComponentSwizzle) -> String {
    format!("{swizzle:?}").to_lowercase()
}

/// `getComponentMappingCaseName`
fn component_mapping_case_name(mapping: &vk::ComponentMapping) -> String {
    format!(
        "{}_{}_{}_{}",
        component_swizzle_case_name(mapping.r),
        component_swizzle_case_name(mapping.g),
        component_swizzle_case_name(mapping.b),
        component_swizzle_case_name(mapping.a)
    )
}

/// `getComponentMappingPermutations` - the channels rearranged by shifting their positions
fn component_mapping_permutations(mapping: &vk::ComponentMapping) -> Vec<vk::ComponentMapping> {
    let channels = [mapping.r, mapping.g, mapping.b, mapping.a];
    (0..4)
        .map(|first| {
            let current: [vk::ComponentSwizzle; 4] = std::array::from_fn(|channel| channels[(first + channel) % 4]);
            vk::ComponentMapping {
                r: current[0],
                g: current[1],
                b: current[2],
                a: current[3],
            }
        })
        .collect()
}

/// `createComponentSwizzleTests`
fn create_component_swizzle_tests(view_type: vk::ImageViewType, image_format: vk::Format) -> TestCaseGroup {
    let array_size = match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_2D | vk::ImageViewType::_3D => 1,
        vk::ImageViewType::CUBE => 6,
        _ => get_array_size(view_type),
    };
    let subresource_range = range(0, get_num_levels(view_type), 0, array_size);

    let mut swizzle_tests = TestCaseGroup::new("component_swizzle");
    for component_mapping in component_mapping_permutations(&RGBA_MAPPING) {
        let base_name = component_mapping_case_name(&component_mapping);
        for (name, use_compute) in [(base_name.clone(), false), (format!("{base_name}_compute"), true)] {
            swizzle_tests.add_child(Box::new(ImageViewCase {
                name,
                image_view_type: view_type,
                image_format,
                sampler_lod: 0.0,
                component_mapping,
                subresource_range,
                use_compute,
            }) as Box<dyn TestCase>);
        }
    }
    swizzle_tests
}

/// `createImageViewTests`
pub fn create_image_view_tests() -> TestCaseGroup {
    const IMAGE_VIEW_TYPES: [(vk::ImageViewType, &str); 7] = [
        (vk::ImageViewType::_1D, "1d"),
        (vk::ImageViewType::_1D_ARRAY, "1d_array"),
        (vk::ImageViewType::_2D, "2d"),
        (vk::ImageViewType::_2D_ARRAY, "2d_array"),
        (vk::ImageViewType::_3D, "3d"),
        (vk::ImageViewType::CUBE, "cube"),
        (vk::ImageViewType::CUBE_ARRAY, "cube_array"),
    ];
    const ASTC_3D_FORMATS: [vk::Format; 30] = [
        vk::Format::ASTC_3X3X3_UNORM_BLOCK_EXT,
        vk::Format::ASTC_3X3X3_SRGB_BLOCK_EXT,
        vk::Format::ASTC_3X3X3_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_4X3X3_UNORM_BLOCK_EXT,
        vk::Format::ASTC_4X3X3_SRGB_BLOCK_EXT,
        vk::Format::ASTC_4X3X3_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_4X4X3_UNORM_BLOCK_EXT,
        vk::Format::ASTC_4X4X3_SRGB_BLOCK_EXT,
        vk::Format::ASTC_4X4X3_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_4X4X4_UNORM_BLOCK_EXT,
        vk::Format::ASTC_4X4X4_SRGB_BLOCK_EXT,
        vk::Format::ASTC_4X4X4_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_5X4X4_UNORM_BLOCK_EXT,
        vk::Format::ASTC_5X4X4_SRGB_BLOCK_EXT,
        vk::Format::ASTC_5X4X4_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_5X5X4_UNORM_BLOCK_EXT,
        vk::Format::ASTC_5X5X4_SRGB_BLOCK_EXT,
        vk::Format::ASTC_5X5X4_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_5X5X5_UNORM_BLOCK_EXT,
        vk::Format::ASTC_5X5X5_SRGB_BLOCK_EXT,
        vk::Format::ASTC_5X5X5_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_6X5X5_UNORM_BLOCK_EXT,
        vk::Format::ASTC_6X5X5_SRGB_BLOCK_EXT,
        vk::Format::ASTC_6X5X5_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_6X6X5_UNORM_BLOCK_EXT,
        vk::Format::ASTC_6X6X5_SRGB_BLOCK_EXT,
        vk::Format::ASTC_6X6X5_SFLOAT_BLOCK_EXT,
        vk::Format::ASTC_6X6X6_UNORM_BLOCK_EXT,
        vk::Format::ASTC_6X6X6_SRGB_BLOCK_EXT,
        vk::Format::ASTC_6X6X6_SFLOAT_BLOCK_EXT,
    ];

    let mut image_tests = TestCaseGroup::new("image_view");
    let mut view_type_tests = TestCaseGroup::new("view_type");

    for (view_type, view_name) in IMAGE_VIEW_TYPES {
        let mut view_type_group = TestCaseGroup::new(view_name);
        let mut format_tests = TestCaseGroup::new("format");

        for format in IMAGE_VIEW_FORMATS {
            // Do not use compressed formats with 1D and 1D array textures.
            if is_compressed_format(format)
                && (view_type == vk::ImageViewType::_1D || view_type == vk::ImageViewType::_1D_ARRAY)
            {
                break;
            }

            let mut format_group = TestCaseGroup::new(format_case_name(format));
            format_group.add_child(create_component_swizzle_tests(view_type, format));
            format_group.add_child(create_subresource_range_tests(view_type, format));
            format_tests.add_child(format_group);
        }

        // only use astc 3D formats with 3D textures.
        if view_type == vk::ImageViewType::_3D {
            for format in ASTC_3D_FORMATS {
                let mut format_group = TestCaseGroup::new(format_case_name(format));
                format_group.add_child(create_component_swizzle_tests(view_type, format));
                format_group.add_child(create_subresource_range_tests(view_type, format));
                format_tests.add_child(format_group);
            }
        }

        view_type_group.add_child(format_tests);
        view_type_tests.add_child(view_type_group);
    }

    image_tests.add_child(view_type_tests);
    image_tests
}
