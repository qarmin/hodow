// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineSamplerTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `SamplerTest` and its subclasses are one `SamplerCase` with a `SamplerKind`; the
// shaders are the ones of image_sampling_instance.rs. The min and max reduction cases run with `AmbientReduction` of the lookup verifier (level samples only), since the lookup
// verifier does not know reduction. `view_type` is ported here, the exact sampling, max sampler lod bias and border swizzle groups
// are in their own files.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::pixel::{has_depth_component, has_stencil_component};
use crate::tcu::{TestError, map_vk_format};
use crate::vk::compressed_formats::{is_astc_3d_format, is_astc_hdr_format, is_compressed_format};
use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_sampling_instance::{
    ImageSamplingInstance, ImageSamplingInstanceParams, SamplerParams, check_support_astc_format,
    check_support_image_sampling_instance, sampler_program,
};
use crate::vkt::tests::pipeline::image_util::{
    BorderColor, create_test_quad_mosaic, format_case_name, get_format_border_color, get_format_custom_border_color,
    is_depth_stencil_format, is_int_format, is_uint_format,
};
use crate::vkt::tests::pipeline::sampler_exact_tests::{
    create_exact_sampling_tests, create_max_sampler_lod_bias_tests,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `SamplerViewType`
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct SamplerViewType {
    pub view_type: vk::ImageViewType,
    pub normalized: bool,
}

impl SamplerViewType {
    pub fn new(view_type: vk::ImageViewType) -> Self {
        Self {
            view_type,
            normalized: true,
        }
    }

    pub fn unnormalized(view_type: vk::ImageViewType) -> Self {
        debug_assert!(view_type == vk::ImageViewType::_2D || view_type == vk::ImageViewType::_1D);
        Self {
            view_type,
            normalized: false,
        }
    }
}

/// The `TestCaseConfig` of `createSamplerAddressModesTests`
#[derive(Clone, Copy)]
struct AddressModesConfig {
    u: vk::SamplerAddressMode,
    v: vk::SamplerAddressMode,
    w: vk::SamplerAddressMode,
    border: BorderColor,
    custom_formatless: bool,
    custom_float: [f32; 4],
    custom_int: [i32; 4],
}

#[derive(Clone)]
enum SamplerKind {
    MagFilter {
        filter: vk::Filter,
        reduction: Option<(vk::ComponentMapping, vk::SamplerReductionMode)>,
    },
    MinFilter {
        filter: vk::Filter,
        reduction: Option<(vk::ComponentMapping, vk::SamplerReductionMode)>,
    },
    Lod {
        mipmap_mode: vk::SamplerMipmapMode,
        min_lod: f32,
        max_lod: f32,
        mip_lod_bias: f32,
    },
    AddressModes(AddressModesConfig),
}

/// `SamplerTest` and its subclasses
pub struct SamplerCase {
    name: String,
    view_type: SamplerViewType,
    format: vk::Format,
    image_size: i32,
    sampler_lod: f32,
    separate_stencil_usage: bool,
    sample_stencil: bool,
    use_compute: bool,
    kind: SamplerKind,
}

fn get_array_size(view_type: vk::ImageViewType) -> i32 {
    match view_type {
        vk::ImageViewType::_1D_ARRAY | vk::ImageViewType::_2D_ARRAY | vk::ImageViewType::CUBE => 6,
        vk::ImageViewType::CUBE_ARRAY => 36,
        _ => 1,
    }
}

fn get_image_size(view_type: vk::ImageViewType, size: i32) -> [i32; 3] {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => [size, 1, 1],
        vk::ImageViewType::_3D => [size, size, 4],
        _ => [size, size, 1],
    }
}

const RGBA_MAPPING: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::R,
    g: vk::ComponentSwizzle::G,
    b: vk::ComponentSwizzle::B,
    a: vk::ComponentSwizzle::A,
};

impl SamplerCase {
    #[allow(clippy::too_many_arguments)]
    fn new(
        name: impl Into<String>,
        view_type: SamplerViewType,
        format: vk::Format,
        image_size: i32,
        sampler_lod: f32,
        separate_stencil_usage: bool,
        sample_stencil: bool,
        use_compute: bool,
        kind: SamplerKind,
    ) -> Self {
        debug_assert!(!separate_stencil_usage || !sample_stencil);
        Self {
            name: name.into(),
            view_type,
            format,
            image_size,
            sampler_lod,
            separate_stencil_usage,
            sample_stencil,
            use_compute,
            kind,
        }
    }

    /// `getRenderSize`
    fn render_size(&self) -> [u32; 2] {
        let base = if self.view_type.view_type == vk::ImageViewType::_1D
            || self.view_type.view_type == vk::ImageViewType::_2D
        {
            [16, 16]
        } else {
            [16 * 3, 16 * 2]
        };
        match self.kind {
            SamplerKind::AddressModes(_) => base.map(|v| 4 * v),
            _ => base,
        }
    }

    /// `createVertices`
    fn create_vertices(&self) -> Vec<crate::vkt::tests::pipeline::image_util::Vertex4Tex4> {
        let mut vertices = create_test_quad_mosaic(self.view_type.view_type);
        for vertex in vertices.iter_mut() {
            for coord in vertex.tex_coord[..3].iter_mut() {
                *coord += 0.002;
            }
            if !self.view_type.normalized {
                let image_size = self.image_size as f32;
                for coord in vertex.tex_coord.iter_mut() {
                    *coord *= image_size;
                }
            }
        }

        if let SamplerKind::AddressModes(_) = self.kind {
            match self.view_type.view_type {
                vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => {
                    for vertex in vertices.iter_mut() {
                        vertex.tex_coord[0] = (vertex.tex_coord[0] - 0.5) * 4.0;
                    }
                }
                vk::ImageViewType::_2D | vk::ImageViewType::_2D_ARRAY => {
                    for vertex in vertices.iter_mut() {
                        for coord in vertex.tex_coord[..2].iter_mut() {
                            *coord = (*coord - 0.5) * 4.0;
                        }
                    }
                }
                vk::ImageViewType::_3D => {
                    for vertex in vertices.iter_mut() {
                        for coord in vertex.tex_coord[..3].iter_mut() {
                            *coord = (*coord - 0.5) * 4.0;
                        }
                    }
                }
                _ => {}
            }
        }

        vertices
    }

    /// `getSamplerCreateInfo`
    fn sampler_params(&self) -> SamplerParams {
        let normalized = self.view_type.normalized;
        let mut params = SamplerParams::default_params(
            get_format_border_color(BorderColor::TransparentBlack, self.format, self.sample_stencil),
            if normalized { 0.25 } else { 0.0 },
            !normalized,
        );

        match &self.kind {
            SamplerKind::MagFilter { filter, reduction } => {
                params.mag_filter = *filter;
                params.reduction_mode = reduction.map(|(_, mode)| mode);
            }
            SamplerKind::MinFilter { filter, reduction } => {
                params.min_filter = *filter;
                params.min_lod = 0.01;
                params.reduction_mode = reduction.map(|(_, mode)| mode);
            }
            SamplerKind::Lod {
                mipmap_mode,
                min_lod,
                max_lod,
                mip_lod_bias,
            } => {
                params.mipmap_mode = *mipmap_mode;
                params.min_lod = *min_lod;
                params.max_lod = *max_lod;
                params.mip_lod_bias = *mip_lod_bias;
            }
            SamplerKind::AddressModes(config) => {
                params.address_mode_u = config.u;
                params.address_mode_v = config.v;
                params.address_mode_w = config.w;
                params.border_color = get_format_border_color(config.border, self.format, self.sample_stencil);
                if config.border == BorderColor::Custom {
                    let value = get_format_custom_border_color(
                        config.custom_float,
                        config.custom_int,
                        self.format,
                        self.sample_stencil,
                    );
                    params.custom_border_color = Some((
                        value,
                        if config.custom_formatless {
                            vk::Format::UNDEFINED
                        } else {
                            self.format
                        },
                    ));
                }
            }
        }

        params
    }

    /// `getComponentMapping`
    fn component_mapping(&self) -> vk::ComponentMapping {
        match &self.kind {
            SamplerKind::MagFilter {
                reduction: Some((mapping, _)),
                ..
            }
            | SamplerKind::MinFilter {
                reduction: Some((mapping, _)),
                ..
            } => *mapping,
            _ => RGBA_MAPPING,
        }
    }

    /// `getImageSamplingInstanceParams`
    fn instance_params(&self) -> ImageSamplingInstanceParams {
        let view_type = self.view_type.view_type;
        let is_ds_format = is_depth_stencil_format(self.format);
        let image_aspect = if is_ds_format {
            if self.sample_stencil {
                vk::ImageAspectFlags::STENCIL
            } else {
                vk::ImageAspectFlags::DEPTH
            }
        } else {
            vk::ImageAspectFlags::COLOR
        };
        let mip_levels = if self.view_type.normalized {
            self.image_size.ilog2() + 1
        } else {
            1
        };
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: image_aspect,
            base_mip_level: 0,
            level_count: mip_levels,
            base_array_layer: 0,
            layer_count: get_array_size(view_type) as u32,
        };

        let mut params = ImageSamplingInstanceParams::new(
            self.render_size(),
            view_type,
            self.format,
            get_image_size(view_type, self.image_size),
            get_array_size(view_type),
            self.component_mapping(),
            subresource_range,
            self.sampler_params(),
            self.sampler_lod,
            self.create_vertices(),
        );
        params.separate_stencil_usage = self.separate_stencil_usage;
        params.use_compute = self.use_compute;
        params.explicit_lod = self.sampler_lod > 0.0 || !self.view_type.normalized;
        params.sample_stencil = self.sample_stencil;
        params
    }
}

impl TestCase for SamplerCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if is_astc_3d_format(self.format) {
            check_support_astc_format(context, self.format)?;
        }

        if self.use_compute && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported(
                "Exclusive compute queue not supported.".to_string(),
            ));
        }

        if self.format == vk::Format::A8_UNORM || self.format == vk::Format::A1B5G5R5_UNORM_PACK16 {
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

fn add_case(group: &mut TestCaseGroup, case: SamplerCase) {
    group.add_child(Box::new(case) as Box<dyn TestCase>);
}

fn is_float_or_compressed(format: vk::Format) -> bool {
    is_compressed_format(format) || (!is_int_format(format) && !is_uint_format(format))
}

/// `createSamplerMagFilterTests`
fn create_sampler_mag_filter_tests(
    view_type: SamplerViewType,
    format: vk::Format,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("mag_filter");
    let case = |name: &str, filter: vk::Filter, compute: bool| {
        SamplerCase::new(
            name,
            view_type,
            format,
            8,
            0.0,
            separate_stencil_usage,
            false,
            compute,
            SamplerKind::MagFilter {
                filter,
                reduction: None,
            },
        )
    };

    if view_type.normalized && is_float_or_compressed(format) {
        add_case(&mut group, case("linear", vk::Filter::LINEAR, false));
        if !separate_stencil_usage {
            add_case(&mut group, case("linear_compute", vk::Filter::LINEAR, true));
        }
    }
    add_case(&mut group, case("nearest", vk::Filter::NEAREST, false));
    if !separate_stencil_usage {
        add_case(&mut group, case("nearest_compute", vk::Filter::NEAREST, true));
    }
    group
}

/// `createSamplerMinFilterTests`
fn create_sampler_min_filter_tests(
    view_type: SamplerViewType,
    format: vk::Format,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("min_filter");
    let case = |name: &str, filter: vk::Filter, compute: bool| {
        SamplerCase::new(
            name,
            view_type,
            format,
            32,
            0.0,
            separate_stencil_usage,
            false,
            compute,
            SamplerKind::MinFilter {
                filter,
                reduction: None,
            },
        )
    };

    if view_type.normalized && is_float_or_compressed(format) {
        add_case(&mut group, case("linear", vk::Filter::LINEAR, false));
        if !separate_stencil_usage {
            add_case(&mut group, case("linear_compute", vk::Filter::LINEAR, true));
        }
    }
    add_case(&mut group, case("nearest", vk::Filter::NEAREST, false));
    if !separate_stencil_usage {
        add_case(&mut group, case("nearest_compute", vk::Filter::NEAREST, true));
    }
    group
}

const fn mapping(
    r: vk::ComponentSwizzle,
    g: vk::ComponentSwizzle,
    b: vk::ComponentSwizzle,
    a: vk::ComponentSwizzle,
) -> vk::ComponentMapping {
    vk::ComponentMapping { r, g, b, a }
}

const REDUCE_FILTER_COMPONENT_MAPPINGS: [vk::ComponentMapping; 5] = [
    mapping(
        vk::ComponentSwizzle::IDENTITY,
        vk::ComponentSwizzle::ZERO,
        vk::ComponentSwizzle::ZERO,
        vk::ComponentSwizzle::ZERO,
    ),
    mapping(
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::ZERO,
        vk::ComponentSwizzle::ZERO,
        vk::ComponentSwizzle::ZERO,
    ),
    mapping(
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::G,
        vk::ComponentSwizzle::B,
        vk::ComponentSwizzle::A,
    ),
    mapping(
        vk::ComponentSwizzle::B,
        vk::ComponentSwizzle::G,
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::A,
    ),
    mapping(
        vk::ComponentSwizzle::ONE,
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::R,
    ),
];

/// `getShortComponentSwizzleName`
fn short_component_swizzle_name(swizzle: vk::ComponentSwizzle) -> String {
    format!("{swizzle:?}").to_lowercase()
}

/// `getComponentMappingGroupName`
fn component_mapping_group_name(mapping: &vk::ComponentMapping) -> String {
    format!(
        "comp_{}_{}_{}_{}",
        short_component_swizzle_name(mapping.r),
        short_component_swizzle_name(mapping.g),
        short_component_swizzle_name(mapping.b),
        short_component_swizzle_name(mapping.a)
    )
}

/// `createSamplerMagReduceFilterTests` (`min` is false) and `createSamplerMinReduceFilterTests`
fn create_sampler_reduce_filter_tests(
    min: bool,
    view_type: SamplerViewType,
    format: vk::Format,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(if min { "min_reduce" } else { "mag_reduce" });
    let image_size = if min { 32 } else { 8 };

    for component_mapping in REDUCE_FILTER_COMPONENT_MAPPINGS {
        let mut component_group = TestCaseGroup::new(component_mapping_group_name(&component_mapping));
        let case = |name: &str, mode: vk::SamplerReductionMode, compute: bool| {
            let reduction = Some((component_mapping, mode));
            let kind = if min {
                SamplerKind::MinFilter {
                    filter: vk::Filter::LINEAR,
                    reduction,
                }
            } else {
                SamplerKind::MagFilter {
                    filter: vk::Filter::LINEAR,
                    reduction,
                }
            };
            SamplerCase::new(
                name,
                view_type,
                format,
                image_size,
                0.0,
                separate_stencil_usage,
                false,
                compute,
                kind,
            )
        };

        if is_float_or_compressed(format) {
            add_case(
                &mut component_group,
                case("average", vk::SamplerReductionMode::WEIGHTED_AVERAGE, false),
            );
            if !separate_stencil_usage {
                add_case(
                    &mut component_group,
                    case("average_compute", vk::SamplerReductionMode::WEIGHTED_AVERAGE, true),
                );
            }
        }
        add_case(&mut component_group, case("min", vk::SamplerReductionMode::MIN, false));
        if !separate_stencil_usage {
            add_case(
                &mut component_group,
                case("min_compute", vk::SamplerReductionMode::MIN, true),
            );
        }
        add_case(&mut component_group, case("max", vk::SamplerReductionMode::MAX, false));
        if !separate_stencil_usage {
            add_case(
                &mut component_group,
                case("max_compute", vk::SamplerReductionMode::MAX, true),
            );
        }
        group.add_child(component_group);
    }

    group
}

/// `createSamplerLodTests`
fn create_sampler_lod_tests(
    view_type: SamplerViewType,
    format: vk::Format,
    mipmap_mode: vk::SamplerMipmapMode,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    // name, minLod, maxLod, mipLodBias, lod
    const CONFIGS: [(&str, f32, f32, f32, f32); 7] = [
        ("equal_min_3_max_3", 3.0, 3.0, 0.0, 0.0),
        ("select_min_1", 1.0, 5.0, 0.0, 0.0),
        ("select_max_4", 0.0, 4.0, 0.0, 5.0),
        ("select_bias_2_1", 0.0, 2.1, 5.0, 0.0),
        ("select_bias_2_5", 0.0, 5.0, 2.5, 0.00001),
        ("select_bias_3_1", 0.0, 5.0, -0.9, 4.0),
        ("select_bias_3_7", 0.0, 5.0, 3.0, 0.7),
    ];

    let mut group = TestCaseGroup::new("lod");
    for (name, min_lod, max_lod, mip_lod_bias, lod) in CONFIGS {
        let case = |name: String, compute: bool| {
            SamplerCase::new(
                name,
                view_type,
                format,
                32,
                lod,
                separate_stencil_usage,
                false,
                compute,
                SamplerKind::Lod {
                    mipmap_mode,
                    min_lod,
                    max_lod,
                    mip_lod_bias,
                },
            )
        };

        add_case(&mut group, case(name.to_string(), false));
        if !separate_stencil_usage {
            add_case(&mut group, case(format!("{name}_compute"), true));
        }
    }
    group
}

/// `createSamplerMipmapTests`
fn create_sampler_mipmap_tests(
    view_type: SamplerViewType,
    format: vk::Format,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("mipmap");

    let mut nearest = TestCaseGroup::new("nearest");
    nearest.add_child(create_sampler_lod_tests(
        view_type,
        format,
        vk::SamplerMipmapMode::NEAREST,
        separate_stencil_usage,
    ));
    group.add_child(nearest);

    if is_float_or_compressed(format) {
        let mut linear = TestCaseGroup::new("linear");
        linear.add_child(create_sampler_lod_tests(
            view_type,
            format,
            vk::SamplerMipmapMode::LINEAR,
            separate_stencil_usage,
        ));
        group.add_child(linear);
    }

    group
}

/// `getAddressModesCaseName`
fn get_address_modes_case_name(config: &AddressModesConfig, sample_stencil: bool) -> String {
    // `getSamplerAddressModeName` without `VK_SAMPLER_ADDRESS_`, lowercased
    let mode_name = |mode: vk::SamplerAddressMode| format!("mode_{mode:?}").to_lowercase();
    let mut name = String::new();

    if config.u == config.v && config.v == config.w {
        name += "all_";
        name += &mode_name(config.u);
        if config.u == vk::SamplerAddressMode::CLAMP_TO_BORDER {
            name += "_";
            name += config.border.name();
        }
    } else {
        name += &format!(
            "uvw_{}_{}_{}",
            mode_name(config.u),
            mode_name(config.v),
            mode_name(config.w)
        );
    }

    if config.border == BorderColor::Custom {
        name += "_";
        for value in config.custom_int {
            name += &value.to_string();
        }
        if config.custom_formatless {
            name += "_formatless";
        }
    }
    if sample_stencil {
        name += "_stencil";
    }
    name
}

fn address_modes_configs() -> Vec<AddressModesConfig> {
    use vk::SamplerAddressMode as M;
    let plain = |u: M, v: M, w: M, border: BorderColor| AddressModesConfig {
        u,
        v,
        w,
        border,
        custom_formatless: false,
        custom_float: [0.0; 4],
        custom_int: [0; 4],
    };
    let custom = |float: [f32; 4], int: [i32; 4], formatless: bool| AddressModesConfig {
        u: M::CLAMP_TO_BORDER,
        v: M::CLAMP_TO_BORDER,
        w: M::CLAMP_TO_BORDER,
        border: BorderColor::Custom,
        custom_formatless: formatless,
        custom_float: float,
        custom_int: int,
    };
    let white = BorderColor::OpaqueWhite;
    let transparent = BorderColor::TransparentBlack;

    vec![
        plain(M::CLAMP_TO_EDGE, M::CLAMP_TO_EDGE, M::CLAMP_TO_EDGE, transparent),
        plain(M::REPEAT, M::REPEAT, M::REPEAT, transparent),
        plain(M::MIRRORED_REPEAT, M::MIRRORED_REPEAT, M::MIRRORED_REPEAT, transparent),
        plain(
            M::MIRROR_CLAMP_TO_EDGE,
            M::MIRROR_CLAMP_TO_EDGE,
            M::MIRROR_CLAMP_TO_EDGE,
            transparent,
        ),
        plain(M::CLAMP_TO_BORDER, M::CLAMP_TO_BORDER, M::CLAMP_TO_BORDER, transparent),
        plain(
            M::CLAMP_TO_BORDER,
            M::CLAMP_TO_BORDER,
            M::CLAMP_TO_BORDER,
            BorderColor::OpaqueBlack,
        ),
        plain(M::CLAMP_TO_BORDER, M::CLAMP_TO_BORDER, M::CLAMP_TO_BORDER, white),
        plain(M::CLAMP_TO_BORDER, M::MIRROR_CLAMP_TO_EDGE, M::REPEAT, white),
        plain(M::CLAMP_TO_BORDER, M::MIRRORED_REPEAT, M::MIRROR_CLAMP_TO_EDGE, white),
        plain(M::CLAMP_TO_BORDER, M::REPEAT, M::MIRRORED_REPEAT, white),
        plain(M::CLAMP_TO_BORDER, M::CLAMP_TO_EDGE, M::CLAMP_TO_EDGE, white),
        plain(M::MIRROR_CLAMP_TO_EDGE, M::CLAMP_TO_BORDER, M::MIRRORED_REPEAT, white),
        plain(
            M::MIRROR_CLAMP_TO_EDGE,
            M::MIRROR_CLAMP_TO_EDGE,
            M::CLAMP_TO_BORDER,
            white,
        ),
        plain(M::MIRROR_CLAMP_TO_EDGE, M::MIRRORED_REPEAT, M::REPEAT, white),
        plain(
            M::MIRROR_CLAMP_TO_EDGE,
            M::CLAMP_TO_EDGE,
            M::MIRROR_CLAMP_TO_EDGE,
            white,
        ),
        plain(M::MIRROR_CLAMP_TO_EDGE, M::REPEAT, M::CLAMP_TO_EDGE, white),
        plain(M::MIRRORED_REPEAT, M::CLAMP_TO_BORDER, M::MIRROR_CLAMP_TO_EDGE, white),
        plain(M::REPEAT, M::MIRROR_CLAMP_TO_EDGE, M::MIRROR_CLAMP_TO_EDGE, white),
        plain(M::MIRRORED_REPEAT, M::REPEAT, M::CLAMP_TO_BORDER, white),
        plain(M::MIRRORED_REPEAT, M::CLAMP_TO_EDGE, M::REPEAT, white),
        plain(M::REPEAT, M::CLAMP_TO_BORDER, M::CLAMP_TO_EDGE, white),
        plain(M::REPEAT, M::MIRRORED_REPEAT, M::CLAMP_TO_BORDER, white),
        plain(M::REPEAT, M::CLAMP_TO_EDGE, M::MIRRORED_REPEAT, white),
        plain(M::MIRRORED_REPEAT, M::MIRROR_CLAMP_TO_EDGE, M::CLAMP_TO_EDGE, white),
        plain(M::CLAMP_TO_EDGE, M::CLAMP_TO_EDGE, M::CLAMP_TO_BORDER, white),
        plain(M::CLAMP_TO_EDGE, M::CLAMP_TO_BORDER, M::REPEAT, white),
        plain(M::CLAMP_TO_EDGE, M::REPEAT, M::MIRROR_CLAMP_TO_EDGE, white),
        plain(M::CLAMP_TO_EDGE, M::MIRRORED_REPEAT, M::CLAMP_TO_EDGE, white),
        plain(M::CLAMP_TO_EDGE, M::MIRROR_CLAMP_TO_EDGE, M::MIRRORED_REPEAT, white),
        custom([0.0, 0.0, 0.0, 0.0], [0, 0, 0, 0], false),
        custom([0.0, 0.0, 1.0, 1.0], [0, 0, 1, 1], false),
        custom([1.0, 0.0, 0.0, 0.0], [1, 0, 0, 0], false),
        custom([1.0, 0.0, 0.0, 1.0], [1, 0, 0, 1], false),
        custom([1.0, 0.0, 1.0, 1.0], [1, 0, 1, 1], false),
        custom([1.0, 1.0, 0.0, 1.0], [1, 1, 0, 1], false),
        custom([1.0, 0.0, 1.0, 1.0], [1, 0, 1, 1], true),
        custom([1.0, 1.0, 0.0, 1.0], [1, 1, 0, 1], true),
    ]
}

/// `createSamplerAddressModesTests`
fn create_sampler_address_modes_tests(
    view_type: SamplerViewType,
    format: vk::Format,
    separate_stencil_usage: bool,
) -> TestCaseGroup {
    use vk::SamplerAddressMode as M;
    let mut group = TestCaseGroup::new("address_modes");

    for config in address_modes_configs() {
        if !view_type.normalized
            && ((config.u != M::CLAMP_TO_EDGE && config.u != M::CLAMP_TO_BORDER)
                || (config.v != M::CLAMP_TO_EDGE && config.v != M::CLAMP_TO_BORDER))
        {
            continue;
        }

        if matches!(
            format,
            vk::Format::B4G4R4A4_UNORM_PACK16
                | vk::Format::B5G6R5_UNORM_PACK16
                | vk::Format::A1B5G5R5_UNORM_PACK16
                | vk::Format::B5G5R5A1_UNORM_PACK16
        ) && config.border == BorderColor::Custom
            && config.custom_formatless
        {
            continue;
        }

        for sample_stencil in [false, true] {
            let is_ds_format = is_depth_stencil_format(format);
            if separate_stencil_usage && sample_stencil {
                continue;
            }
            if !is_ds_format && sample_stencil {
                continue;
            }
            if is_ds_format {
                let Some(tcu_format) = map_vk_format(format) else {
                    continue;
                };
                if !sample_stencil && !has_depth_component(tcu_format.order) {
                    continue;
                }
                if sample_stencil && !has_stencil_component(tcu_format.order) {
                    continue;
                }
            }

            let name = get_address_modes_case_name(&config, sample_stencil);
            let case = |name: String, compute: bool| {
                SamplerCase::new(
                    name,
                    view_type,
                    format,
                    8,
                    0.0,
                    separate_stencil_usage,
                    sample_stencil,
                    compute,
                    SamplerKind::AddressModes(config),
                )
            };

            add_case(&mut group, case(name.clone(), false));
            if !separate_stencil_usage {
                add_case(&mut group, case(format!("{name}_compute"), true));
            }
        }
    }

    group
}

fn sampler_formats() -> Vec<vk::Format> {
    use vk::Format as F;
    let mut formats = vec![
        // Packed formats
        F::R4G4_UNORM_PACK8,
        F::R4G4B4A4_UNORM_PACK16,
        F::R5G6B5_UNORM_PACK16,
        F::R5G5B5A1_UNORM_PACK16,
        F::A2B10G10R10_UNORM_PACK32,
        F::A2R10G10B10_UINT_PACK32,
        F::B10G11R11_UFLOAT_PACK32,
        F::E5B9G9R9_UFLOAT_PACK32,
        F::B4G4R4A4_UNORM_PACK16,
        F::B5G5R5A1_UNORM_PACK16,
        F::A1R5G5B5_UNORM_PACK16,
        F::A4R4G4B4_UNORM_PACK16,
        F::A4B4G4R4_UNORM_PACK16,
        F::A1B5G5R5_UNORM_PACK16,
        // Pairwise combinations of 8-bit channel formats, UNORM/SNORM/SINT/UINT/SRGB type x 1-to-4 channels x RGBA/BGRA order
        F::R8_SRGB,
        F::R8G8B8_UINT,
        F::B8G8R8A8_SINT,
        F::R8G8_UNORM,
        F::B8G8R8_SNORM,
        F::R8G8B8A8_SNORM,
        F::R8G8_UINT,
        F::R8_SINT,
        F::R8G8B8A8_SRGB,
        F::R8G8B8A8_UNORM,
        F::B8G8R8A8_UNORM,
        F::B8G8R8_SRGB,
        F::R8G8_SRGB,
        F::R8_UINT,
        F::R8G8B8A8_UINT,
        F::R8G8_SINT,
        F::R8_SNORM,
        F::B8G8R8_SINT,
        F::R8G8_SNORM,
        F::B8G8R8_UNORM,
        F::R8_UNORM,
        F::A8_UNORM,
        // Pairwise combinations of 16/32-bit channel formats x SINT/UINT/SFLOAT type x 1-to-4 channels
        F::R32G32_SFLOAT,
        F::R32G32B32_UINT,
        F::R16G16B16A16_SFLOAT,
        F::R16G16_UINT,
        F::R32G32B32A32_SINT,
        F::R16G16B16_SINT,
        F::R16_SFLOAT,
        F::R32_SINT,
        F::R32_UINT,
        F::R16G16B16_SFLOAT,
        F::R16G16_SINT,
        // More 16/32-bit formats required for testing VK_EXT_sampler_filter_minmax
        F::R16_UNORM,
        F::R16_SNORM,
        F::R32_SFLOAT,
        // Scaled formats
        F::R8G8B8A8_SSCALED,
        F::A2R10G10B10_USCALED_PACK32,
        // Compressed formats
        F::ETC2_R8G8B8_UNORM_BLOCK,
        F::ETC2_R8G8B8_SRGB_BLOCK,
        F::ETC2_R8G8B8A1_UNORM_BLOCK,
        F::ETC2_R8G8B8A1_SRGB_BLOCK,
        F::ETC2_R8G8B8A8_UNORM_BLOCK,
        F::ETC2_R8G8B8A8_SRGB_BLOCK,
        F::EAC_R11_UNORM_BLOCK,
        F::EAC_R11_SNORM_BLOCK,
        F::EAC_R11G11_UNORM_BLOCK,
        F::EAC_R11G11_SNORM_BLOCK,
        F::ASTC_4X4_UNORM_BLOCK,
        F::ASTC_5X4_SRGB_BLOCK,
        F::ASTC_6X5_UNORM_BLOCK,
        F::ASTC_6X6_SRGB_BLOCK,
        F::ASTC_8X6_UNORM_BLOCK,
        F::ASTC_8X8_SRGB_BLOCK,
        F::ASTC_10X6_UNORM_BLOCK,
        F::ASTC_10X8_SRGB_BLOCK,
        F::ASTC_12X10_UNORM_BLOCK,
        F::ASTC_12X12_SRGB_BLOCK,
    ];

    formats.extend([
        F::ASTC_3X3X3_UNORM_BLOCK_EXT,
        F::ASTC_3X3X3_SRGB_BLOCK_EXT,
        F::ASTC_3X3X3_SFLOAT_BLOCK_EXT,
        F::ASTC_4X3X3_UNORM_BLOCK_EXT,
        F::ASTC_4X3X3_SRGB_BLOCK_EXT,
        F::ASTC_4X3X3_SFLOAT_BLOCK_EXT,
        F::ASTC_4X4X3_UNORM_BLOCK_EXT,
        F::ASTC_4X4X3_SRGB_BLOCK_EXT,
        F::ASTC_4X4X3_SFLOAT_BLOCK_EXT,
        F::ASTC_4X4X4_UNORM_BLOCK_EXT,
        F::ASTC_4X4X4_SRGB_BLOCK_EXT,
        F::ASTC_4X4X4_SFLOAT_BLOCK_EXT,
        F::ASTC_5X4X4_UNORM_BLOCK_EXT,
        F::ASTC_5X4X4_SRGB_BLOCK_EXT,
        F::ASTC_5X4X4_SFLOAT_BLOCK_EXT,
        F::ASTC_5X5X4_UNORM_BLOCK_EXT,
        F::ASTC_5X5X4_SRGB_BLOCK_EXT,
        F::ASTC_5X5X4_SFLOAT_BLOCK_EXT,
        F::ASTC_5X5X5_UNORM_BLOCK_EXT,
        F::ASTC_5X5X5_SRGB_BLOCK_EXT,
        F::ASTC_5X5X5_SFLOAT_BLOCK_EXT,
        F::ASTC_6X5X5_UNORM_BLOCK_EXT,
        F::ASTC_6X5X5_SRGB_BLOCK_EXT,
        F::ASTC_6X5X5_SFLOAT_BLOCK_EXT,
        F::ASTC_6X6X5_UNORM_BLOCK_EXT,
        F::ASTC_6X6X5_SRGB_BLOCK_EXT,
        F::ASTC_6X6X5_SFLOAT_BLOCK_EXT,
        F::ASTC_6X6X6_UNORM_BLOCK_EXT,
        F::ASTC_6X6X6_SRGB_BLOCK_EXT,
        F::ASTC_6X6X6_SFLOAT_BLOCK_EXT,
        // ASTC HDR formats (VK_EXT_texture_compression_astc_hdr)
        F::ASTC_4X4_SFLOAT_BLOCK,
        F::ASTC_5X4_SFLOAT_BLOCK,
        F::ASTC_5X5_SFLOAT_BLOCK,
        F::ASTC_6X5_SFLOAT_BLOCK,
        F::ASTC_6X6_SFLOAT_BLOCK,
        F::ASTC_8X5_SFLOAT_BLOCK,
        F::ASTC_8X6_SFLOAT_BLOCK,
        F::ASTC_8X8_SFLOAT_BLOCK,
        F::ASTC_10X5_SFLOAT_BLOCK,
        F::ASTC_10X6_SFLOAT_BLOCK,
        F::ASTC_10X8_SFLOAT_BLOCK,
        F::ASTC_10X10_SFLOAT_BLOCK,
        F::ASTC_12X10_SFLOAT_BLOCK,
        F::ASTC_12X12_SFLOAT_BLOCK,
        // Depth formats required for testing VK_EXT_sampler_filter_minmax
        F::D16_UNORM,
        F::X8_D24_UNORM_PACK32,
        F::D32_SFLOAT,
        F::D16_UNORM_S8_UINT,
        F::D24_UNORM_S8_UINT,
        F::D32_SFLOAT_S8_UINT,
    ]);

    formats
}

/// `createFormatsSamplerTests`
pub fn create_formats_sampler_tests(separate_stencil_usage: bool) -> TestCaseGroup {
    let image_view_types: [(SamplerViewType, &str); 9] = [
        (SamplerViewType::new(vk::ImageViewType::_1D), "1d"),
        (SamplerViewType::unnormalized(vk::ImageViewType::_1D), "1d_unnormalized"),
        (SamplerViewType::new(vk::ImageViewType::_1D_ARRAY), "1d_array"),
        (SamplerViewType::new(vk::ImageViewType::_2D), "2d"),
        (SamplerViewType::unnormalized(vk::ImageViewType::_2D), "2d_unnormalized"),
        (SamplerViewType::new(vk::ImageViewType::_2D_ARRAY), "2d_array"),
        (SamplerViewType::new(vk::ImageViewType::_3D), "3d"),
        (SamplerViewType::new(vk::ImageViewType::CUBE), "cube"),
        (SamplerViewType::new(vk::ImageViewType::CUBE_ARRAY), "cube_array"),
    ];
    let formats = sampler_formats();

    let mut view_type_tests = TestCaseGroup::new("view_type");

    for (view_type, view_name) in image_view_types {
        let mut view_type_group = TestCaseGroup::new(view_name);
        let mut format_tests = TestCaseGroup::new("format");
        let one_d =
            view_type.view_type == vk::ImageViewType::_1D || view_type.view_type == vk::ImageViewType::_1D_ARRAY;

        for &format in &formats {
            let is_compressed = is_compressed_format(format);
            let is_depth_stencil = !is_compressed
                && map_vk_format(format).is_some_and(|tcu_format| {
                    has_depth_component(tcu_format.order) && has_stencil_component(tcu_format.order)
                });

            if is_compressed {
                // Do not use compressed formats with 1D and 1D array textures.
                if one_d {
                    break;
                }

                // limit number of repeated tests for astc hdr formats
                if is_astc_hdr_format(format) && view_type.view_type != vk::ImageViewType::_2D {
                    continue;
                }

                // Only use ASTC 3D formats with 3D texture.
                if is_astc_3d_format(format) && view_type.view_type != vk::ImageViewType::_3D {
                    continue;
                }
            }

            if separate_stencil_usage && !is_depth_stencil {
                continue;
            }

            let mut format_group = TestCaseGroup::new(format_case_name(format));
            let astc_hdr_2d = is_astc_hdr_format(format) && view_type.view_type == vk::ImageViewType::_2D;

            if !is_compressed && view_type.normalized {
                // Do not include minFilter tests with compressed formats: randomly generated compressed textures are too noisy.
                format_group.add_child(create_sampler_min_filter_tests(
                    view_type,
                    format,
                    separate_stencil_usage,
                ));
                format_group.add_child(create_sampler_reduce_filter_tests(
                    true,
                    view_type,
                    format,
                    separate_stencil_usage,
                ));
            }

            // limit number of repeated tests for astc hdr formats
            if !astc_hdr_2d {
                format_group.add_child(create_sampler_mag_filter_tests(
                    view_type,
                    format,
                    separate_stencil_usage,
                ));
            }

            if view_type.normalized && !astc_hdr_2d {
                format_group.add_child(create_sampler_reduce_filter_tests(
                    false,
                    view_type,
                    format,
                    separate_stencil_usage,
                ));
                format_group.add_child(create_sampler_mipmap_tests(view_type, format, separate_stencil_usage));
            }

            if view_type.view_type != vk::ImageViewType::CUBE && view_type.view_type != vk::ImageViewType::CUBE_ARRAY {
                format_group.add_child(create_sampler_address_modes_tests(
                    view_type,
                    format,
                    separate_stencil_usage,
                ));
            }

            format_tests.add_child(format_group);
        }

        view_type_group.add_child(format_tests);
        view_type_tests.add_child(view_type_group);
    }

    view_type_tests
}

/// `createSamplerTests` for one construction type: the formats tests only for the monolithic one (`genAllTests`), the
/// `separate_stencil_usage` copy of them for every one.
pub fn create_sampler_tests(monolithic: bool, construction: PipelineConstructionType) -> TestCaseGroup {
    let mut sampler_tests = TestCaseGroup::new("sampler");

    if monolithic {
        sampler_tests.add_child(create_formats_sampler_tests(false));
    }
    sampler_tests.add_child(create_exact_sampling_tests(monolithic));

    // tests for VK_EXT_separate_stencil_usage
    let mut separate_stencil_usage_tests = TestCaseGroup::new("separate_stencil_usage");
    separate_stencil_usage_tests.add_child(create_formats_sampler_tests(true));
    sampler_tests.add_child(separate_stencil_usage_tests);

    // Border color swizzle tests; the shader object construction types are not built by them.
    if monolithic && !construction.is_shader_object() {
        sampler_tests.add_child(super::sampler_border_swizzle_tests::create_sampler_border_swizzle_tests(construction));
    }

    sampler_tests.add_child(create_max_sampler_lod_bias_tests(monolithic));

    sampler_tests
}
