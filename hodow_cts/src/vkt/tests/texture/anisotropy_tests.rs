// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureFilteringAnisotropyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The comparisons are logged through `log::info!` only.

use vulkanalia::prelude::v1_0::*;

use super::test_util::{
    Program, RenderRequest, SamplerParams, ShaderParameters, TexKind, pixels_to_surface, render_quad_2d,
};
use crate::generated::shaders::texture_swizzle::TSW_2D_FLOAT_NONE;
use crate::glu::texture_test_util::compute_quad_tex_coord_2d;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::fill_with_grid;
use crate::tcu::{TestError, TestOutcome, TestStatus, Vec2};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_util::create_test_texture;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const ANISOTROPY_TEST_RESOLUTION: u32 = 128;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Mip {
    None,
    Nearest,
    Linear,
}

/// A minification filter: the filter and its mipmap mode
#[derive(Clone, Copy, Debug)]
struct MinFilter {
    name: &'static str,
    linear: bool,
    mip: Mip,
}

/// `AnisotropyParams`
#[derive(Clone, Copy)]
struct AnisotropyParams {
    max_anisotropy: f32,
    min_filter: MinFilter,
    mag_linear: bool,
    single_level_image: bool,
    mip_map: bool,
    use_compute: bool,
}

struct AnisotropyCase {
    name: String,
    params: AnisotropyParams,
}

impl TestCase for AnisotropyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check device for anisotropic filtering support.
        if context.get_device_features().sampler_anisotropy == vk::FALSE {
            return Err(TestError::NotSupported(
                "Skipping anisotropic tests since the device does not support anisotropic filtering.".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        TSW_2D_FLOAT_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AnisotropyInstance {
            context,
            params: self.params,
        })
    }
}

struct AnisotropyInstance<'a> {
    context: &'a Context<'a>,
    params: AnisotropyParams,
}

impl TestInstance for AnisotropyInstance<'_> {
    /// `FilteringAnisotropyInstance`'s constructor and `iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let max_anisotropy = context
            .get_device_properties()
            .limits
            .max_sampler_anisotropy
            .min(params.max_anisotropy);
        let max_level = if params.mip_map {
            ANISOTROPY_TEST_RESOLUTION.ilog2() as usize
        } else {
            0
        };

        let size = [ANISOTROPY_TEST_RESOLUTION as i32, ANISOTROPY_TEST_RESOLUTION as i32, 1];
        let mut texture = create_test_texture(vk::Format::R8G8B8A8_UNORM, vk::ImageViewType::_2D, size, 1)?;
        if params.single_level_image {
            // Add miplevel count (1u) as parameter if we want to test anisotropic filtering on image that has a single mip level.
            texture.truncate_levels(1);
            let grid_size = (ANISOTROPY_TEST_RESOLUTION / 8).max(1);
            fill_with_grid(
                &mut texture.get_level_mut(0, 0),
                grid_size,
                [0.0, 0.0, 0.0, 1.0],
                [1.0; 4],
            );
        } else {
            for level in 0..=max_level {
                let grid_size = ((ANISOTROPY_TEST_RESOLUTION >> level) / 8).max(1);
                fill_with_grid(
                    &mut texture.get_level_mut(level, 0),
                    grid_size,
                    [0.0, 0.0, 0.0, 1.0],
                    [1.0; 4],
                );
            }
        }

        let filter = |linear: bool| {
            if linear {
                vk::Filter::LINEAR
            } else {
                vk::Filter::NEAREST
            }
        };
        let sampler = |anisotropy: Option<f32>| SamplerParams {
            wrap_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            min_filter: filter(params.min_filter.linear),
            mag_filter: filter(params.mag_linear),
            mipmap_mode: if params.min_filter.mip == Mip::Linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if params.mip_map { max_level as f32 } else { 0.25 },
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: anisotropy,
        };

        let positions = [
            -3.5f32, -1.0, 0.0, 3.5, -3.5, 1.0, 0.0, 1.0, 3.5, -1.0, 0.0, 3.5, 3.5, 1.0, 0.0, 1.0,
        ];
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        let render = |anisotropy: Option<f32>| -> Result<crate::tcu::Surface, TestError> {
            let request = RenderRequest {
                texture: &texture,
                format: vk::Format::R8G8B8A8_UNORM,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: ANISOTROPY_TEST_RESOLUTION,
                height: ANISOTROPY_TEST_RESOLUTION,
                tex_width: ANISOTROPY_TEST_RESOLUTION,
                tex_height: ANISOTROPY_TEST_RESOLUTION,
                tex_depth: 1,
                kind: TexKind::D2,
                sampler: sampler(anisotropy),
                tex_coord: &tex_coord,
                positions,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: Program::Float2D,
                parameters: ShaderParameters {
                    bias: 0.0,
                    reference: 0.0,
                    color_scale: [1.0; 4],
                    color_bias: [0.0; 4],
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            Ok(pixels_to_surface(
                &pixels,
                ANISOTROPY_TEST_RESOLUTION,
                ANISOTROPY_TEST_RESOLUTION,
            ))
        };

        // maxAnisotropy 1.0 leaves anisotropic filtering off
        let rendered_frame = render(None)?;
        let rendered_anisotropy_frame = render(if max_anisotropy > 1.0 {
            Some(max_anisotropy)
        } else {
            None
        })?;

        let comparison = fuzzy_compare_ok(
            &rendered_frame.get_const_access(),
            &rendered_anisotropy_frame.get_const_access(),
            0.05,
        )
        .ok_or_else(|| TestError::NotPorted("fuzzy comparison of this format".to_string()))?;
        if !comparison {
            log::info!("Expecting comparison to pass");
            return Ok(TestStatus::fail("Fail"));
        }

        // Anisotropic filtering is implementation dependent. Expecting differences with minification/magnification filter set to NEAREST is too strict.
        // The specification does not require that your aniso & bi-linear filtering are different even in LINEAR, but this check is 'generally' going
        // to detect *some* difference and possibly be useful in catching issues where an implementation hasn't setup their filtering modes correctly.
        let min_is_not_nearest = params.min_filter.linear || params.min_filter.mip != Mip::None;
        if min_is_not_nearest
            && params.mag_linear
            && float_threshold_compare(
                &rendered_frame.get_const_access(),
                &rendered_anisotropy_frame.get_const_access(),
                [0.02; 4],
            )
            .ok
        {
            log::info!("Expecting comparison to fail");
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createFilteringAnisotropyTests`
pub fn create_filtering_anisotropy_tests() -> TestCaseGroup {
    let value_names = ["anisotropy_2", "anisotropy_4", "anisotropy_8", "anisotropy_max"];
    let max_anisotropy = [2.0f32, 4.0, 8.0, 10000.0]; // too huge will be flated to max value
    let mag_filters: [(&str, bool); 2] = [("nearest", false), ("linear", true)];
    let basic_min_filters = [
        MinFilter {
            name: "nearest",
            linear: false,
            mip: Mip::None,
        },
        MinFilter {
            name: "linear",
            linear: true,
            mip: Mip::None,
        },
    ];
    let mipmap_min_filters = [
        MinFilter {
            name: "nearest_mipmap_nearest",
            linear: false,
            mip: Mip::Nearest,
        },
        MinFilter {
            name: "nearest_mipmap_linear",
            linear: false,
            mip: Mip::Linear,
        },
        MinFilter {
            name: "linear_mipmap_nearest",
            linear: true,
            mip: Mip::Nearest,
        },
        MinFilter {
            name: "linear_mipmap_linear",
            linear: true,
            mip: Mip::Linear,
        },
    ];

    let build = |min_filters: &[MinFilter], single_level_image: bool, mip_map: bool| -> TestCaseGroup {
        let mut group = TestCaseGroup::new(if mip_map {
            "mipmap"
        } else if single_level_image {
            "single_level"
        } else {
            "basic"
        });
        for (anisotropy_ndx, &anisotropy) in max_anisotropy.iter().enumerate() {
            let mut level_group = TestCaseGroup::new(value_names[anisotropy_ndx]);
            for &min_filter in min_filters {
                for &(mag_name, mag_linear) in &mag_filters {
                    let mut params = AnisotropyParams {
                        max_anisotropy: anisotropy,
                        min_filter,
                        mag_linear,
                        single_level_image,
                        mip_map,
                        use_compute: false,
                    };
                    let name = format!("mag_{mag_name}_min_{}", min_filter.name);
                    level_group.add_child(Box::new(AnisotropyCase {
                        name: name.clone(),
                        params,
                    }) as Box<dyn TestCase>);

                    // Compute case
                    params.use_compute = true;
                    level_group.add_child(Box::new(AnisotropyCase {
                        name: format!("{name}_compute"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
            group.add_child(level_group);
        }
        group
    };

    let mut filtering_anisotropy = TestCaseGroup::new("filtering_anisotropy");
    filtering_anisotropy.add_child(build(&basic_min_filters, false, false));
    filtering_anisotropy.add_child(build(&basic_min_filters, true, false));
    filtering_anisotropy.add_child(build(&mipmap_min_filters, false, true));
    filtering_anisotropy
}
