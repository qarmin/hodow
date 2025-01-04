// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureWrapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two sub-cases (`m_cases`) run in one
// `iterate()` loop, each with the viewport seed `hash + caseNdx`; any failure fails the case.
//
// The `etc1` group takes its images from `glu::etc1` instead of the test-data archive.
//
// The `enableRelaxedRef` second pass is left out on purpose: it sets `float16TexCoord` and verifies again,
// but `verifyTextureResult` never reads that flag (only `sampleTexture` does), so upstream repeats an
// identical check. Compressed cases build their texture the way upstream does: random ETC2/EAC bytes,
// or random picks from eight valid LDR ASTC blocks.

use vulkanalia::vk;

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::etc1::{ETC1_GL_FORMAT, ETC1_VK_FORMAT, Etc1Image};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d, get_sampler_type};
use crate::glu::texture_test_util_surface::{
    compute_color_bits_threshold, get_bits_vec, get_compare_mask, make_reference_params, verify_texture_result_2d,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{fill_with_component_gradients2, fill_with_component_gradients3, get_texture_format_info};
use crate::tcu::random::Random;
use crate::tcu::surface::Surface;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};
use crate::vk::compressed_formats::{
    get_block_height, get_block_size_in_bytes, get_block_width, is_astc_format, is_astc_srgb_format,
};

const VIEWPORT_WIDTH: i32 = 256;
const VIEWPORT_HEIGHT: i32 = 256;

const ASTC_BLOCK_SIZE: usize = 16;

/// \note All of the following blocks are valid in LDR mode.
const ASTC_BLOCKS: [[u8; ASTC_BLOCK_SIZE]; 8] = [
    [252, 253, 255, 255, 255, 255, 255, 255, 8, 71, 90, 78, 22, 17, 26, 66],
    [
        252, 253, 255, 255, 255, 255, 255, 255, 220, 74, 139, 235, 249, 6, 145, 125,
    ],
    [
        252, 253, 255, 255, 255, 255, 255, 255, 223, 251, 28, 206, 54, 251, 160, 174,
    ],
    [252, 253, 255, 255, 255, 255, 255, 255, 39, 4, 153, 219, 180, 61, 51, 37],
    [67, 2, 0, 254, 1, 0, 64, 215, 83, 211, 159, 105, 41, 140, 50, 2],
    [67, 130, 0, 170, 84, 255, 65, 215, 83, 211, 159, 105, 41, 140, 50, 2],
    [67, 2, 129, 38, 51, 229, 95, 215, 83, 211, 159, 105, 41, 140, 50, 2],
    [67, 130, 193, 56, 213, 144, 95, 215, 83, 211, 159, 105, 41, 140, 50, 2],
];

#[derive(Clone, Copy)]
enum Source {
    /// `(format, dataType)` pair, filled with gradients.
    Uncompressed { format: u32, data_type: u32 },
    /// A compressed format, filled with random (ETC2/EAC) or picked (ASTC) blocks.
    Compressed(vk::Format),
    /// A `GL_ETC1_RGB8_OES` image from `glu::etc1`; the case's width/height are unused.
    Etc1(Etc1Image),
}

struct TextureWrapCase {
    name: String,
    source: Source,
    wrap_s: u32,
    wrap_t: u32,
    min_filter: u32,
    mag_filter: u32,
    width: i32,
    height: i32,
}

fn is_astc_supported(context: &Context) -> bool {
    [
        "GL_KHR_texture_compression_astc_ldr",
        "GL_KHR_texture_compression_astc_hdr",
        "GL_OES_texture_compression_astc",
    ]
    .iter()
    .any(|ext| context.context_info.is_extension_supported(ext))
}

impl TextureWrapCase {
    /// `TextureWrapCase::init`
    fn create_texture<'a>(&self, context: &'a Context) -> Result<Texture2D<'a>, TestError> {
        let render_ctx = &context.render_context;

        match self.source {
            Source::Compressed(format) => {
                let mut rnd = Random::new(de_string_hash(&self.name));
                let num_blocks = (self.width as u32).div_ceil(get_block_width(format)) as usize
                    * (self.height as u32).div_ceil(get_block_height(format)) as usize;
                let block_bytes = get_block_size_in_bytes(format) as usize;
                let mut data = vec![0u8; num_blocks * block_bytes];

                if is_astc_format(format) {
                    // \note Any level of ASTC support is enough, since we're only using LDR blocks.
                    if !is_astc_supported(context) {
                        return Err(TestError::NotSupported("ASTC not supported".to_string()));
                    }
                    debug_assert_eq!(block_bytes, ASTC_BLOCK_SIZE);
                    for block in data.chunks_mut(ASTC_BLOCK_SIZE) {
                        let pick = rnd.get_int(0, ASTC_BLOCKS.len() as i32 - 1) as usize;
                        block.copy_from_slice(&ASTC_BLOCKS[pick]);
                    }
                } else {
                    // Create ETC texture. Any content is valid.
                    for byte in data.iter_mut() {
                        *byte = (rnd.get_uint32() & 0xff) as u8;
                    }
                }

                Texture2D::new_compressed(
                    render_ctx,
                    &context.context_info,
                    format,
                    self.width as u32,
                    self.height as u32,
                    &[data.as_slice()],
                )
            }
            Source::Etc1(image) => Texture2D::new_compressed_with_gl_format(
                render_ctx,
                &context.context_info,
                ETC1_VK_FORMAT,
                Some(ETC1_GL_FORMAT),
                image.width,
                image.height,
                &[image.data],
            ),
            Source::Uncompressed { format, data_type } => {
                let mut texture = Texture2D::new(render_ctx, format, data_type, self.width as u32, self.height as u32)?;

                // Fill level 0.
                texture.ref_texture_mut().alloc_level(0);
                {
                    let mut level0 = texture.ref_texture_mut().level_mut(0);
                    if self.wrap_s == glw::GL_REPEAT || self.wrap_t == glw::GL_REPEAT {
                        // If run in repeat mode, use conical style texture to avoid edge sample result have a huge difference when coordinate offset in allow range.
                        fill_with_component_gradients3(&mut level0, [-0.5, -0.5, -0.5, 1.5], [1.0, 1.0, 1.0, 0.0]);
                    } else {
                        fill_with_component_gradients2(&mut level0, [-0.5, -0.5, -0.5, 1.5], [1.0, 1.0, 1.0, 0.0]);
                    }
                }
                // SAFETY: a current context; `texture` outlives the call.
                unsafe { texture.upload()? };
                Ok(texture)
            }
        }
    }
}

impl TestCase for TextureWrapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        let texture = self.create_texture(context)?;
        if matches!(self.source, Source::Compressed(_) | Source::Etc1(_)) {
            // SAFETY: a current context; `texture` outlives the call.
            unsafe { texture.upload_compressed()? };
        }

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::MediumP);

        // Sub-cases.
        let cases = [
            (Vec2::new(-1.5, -3.0), Vec2::new(1.5, 2.5)),
            (Vec2::new(-0.5, 0.75), Vec2::new(0.25, 1.25)),
        ];
        let mut is_all_ok = true;

        for (case_ndx, &(bottom_left, top_right)) in cases.iter().enumerate() {
            let viewport = RandomViewport::new(
                &render_target,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                de_string_hash(&self.name).wrapping_add(case_ndx as u32),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let tex_format = texture.ref_texture().format();
            let tex_format_info = get_texture_format_info(tex_format);
            // \note For non-sRGB ASTC formats, the values are fp16 in range [0..1], not the range assumed given by tcu::getTextureFormatInfo().
            let use_default_color_scale_and_bias = match self.source {
                Source::Compressed(format) => !is_astc_format(format) || is_astc_srgb_format(format),
                Source::Uncompressed { .. } | Source::Etc1(_) => true,
            };

            // Bind to unit 0.
            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());

                // Setup filtering and wrap modes.
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);
            }
            glu::expect_no_error(gl, "Set texturing state")?;

            // Parameters for reference images.
            let mut ref_params = make_reference_params(
                TextureType::Texture2D,
                self.wrap_s,
                self.wrap_t,
                self.wrap_s,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            ref_params.base.sampler_type = get_sampler_type(tex_format);
            ref_params.base.color_scale = if use_default_color_scale_and_bias {
                Vec4::from_array(tex_format_info.look_up_scale)
            } else {
                Vec4::splat(1.0)
            };
            ref_params.base.color_bias = if use_default_color_scale_and_bias {
                Vec4::from_array(tex_format_info.look_up_bias)
            } else {
                Vec4::splat(0.0)
            };

            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };
            let tex_coord = compute_quad_tex_coord_2d(bottom_left, top_right);
            renderer.render_quad(0, &tex_coord, &ref_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let is_nearest_only = self.min_filter == glw::GL_NEAREST && self.mag_filter == glw::GL_NEAREST;
            let is_srgb = tex_format.order.is_srgb();
            let bits = get_bits_vec(pixel_format);
            let color_bits = bits.map(|b| (b - if is_nearest_only && !is_srgb { 1 } else { 2 }).max(0));
            let color_scale = ref_params.base.color_scale.m_data;
            let threshold = compute_color_bits_threshold(bits, color_bits);

            let lookup_prec = LookupPrecision {
                color_threshold: std::array::from_fn(|c| threshold[c] / color_scale[c]),
                coord_bits: [20, 20, 0],
                uvw_bits: [5, 5, 0],
                color_mask: get_compare_mask(pixel_format),
                ..Default::default()
            };
            let lod_prec = LodPrecision {
                derivate_bits: 18,
                lod_bits: 5,
            };

            let is_ok = verify_texture_result_2d(
                &rendered_frame,
                texture.ref_texture(),
                tex_coord,
                &ref_params,
                &lookup_prec,
                &lod_prec,
                pixel_format,
            )?;
            if !is_ok {
                is_all_ok = false;
            }
        }

        if is_all_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image verification failed"))
        }
    }
}

/// `TextureWrapTests::init`
pub fn create_tests() -> TestCaseGroup {
    const WRAP_MODES: [(&str, u32); 3] = [
        ("clamp", glw::GL_CLAMP_TO_EDGE),
        ("repeat", glw::GL_REPEAT),
        ("mirror", glw::GL_MIRRORED_REPEAT),
    ];
    const FILTERING_MODES: [(&str, u32); 2] = [("nearest", glw::GL_NEAREST), ("linear", glw::GL_LINEAR)];

    let mut group = TestCaseGroup::new("wrap");

    // Wrap x wrap x filter loop shared by every group below.
    let add_wrap_cases = |group: &mut TestCaseGroup, source: Source, width: i32, height: i32, suffix: &str| {
        for &(wrap_s_name, wrap_s) in &WRAP_MODES {
            for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                for &(filter_name, filter) in &FILTERING_MODES {
                    let name = format!("{wrap_s_name}_{wrap_t_name}_{filter_name}_{suffix}");
                    group.add_child(Box::new(TextureWrapCase {
                        name,
                        source,
                        wrap_s,
                        wrap_t,
                        min_filter: filter,
                        mag_filter: filter,
                        width,
                        height,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    };

    // RGBA8 cases.
    {
        let mut rgba8_group = TestCaseGroup::new("rgba8");
        for &(size_name, width, height) in &[("pot", 64, 128), ("npot", 63, 112)] {
            add_wrap_cases(
                &mut rgba8_group,
                Source::Uncompressed {
                    format: glw::GL_RGBA,
                    data_type: glw::GL_UNSIGNED_BYTE,
                },
                width,
                height,
                size_name,
            );
        }
        group.add_child(rgba8_group);
    }

    // ETC1 cases.
    {
        let mut etc1_group = TestCaseGroup::new("etc1");

        // Power-of-two ETC1 texture, then NPOT.
        let images = [
            ("pot", crate::glu::etc1::photo_mip_levels()[0]),
            ("npot", crate::glu::etc1::photo_npot()),
        ];
        for (size_name, image) in images {
            for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                    for &(filter_name, filter) in &FILTERING_MODES {
                        let name = format!("{wrap_s_name}_{wrap_t_name}_{filter_name}_{size_name}");
                        etc1_group.add_child(Box::new(TextureWrapCase {
                            name,
                            source: Source::Etc1(image),
                            wrap_s,
                            wrap_t,
                            min_filter: filter,
                            mag_filter: filter,
                            width: 0,
                            height: 0,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
        group.add_child(etc1_group);
    }

    // ETC-2 (and EAC) cases.
    {
        const ETC2_FORMATS: [(&str, vk::Format); 10] = [
            ("eac_r11", vk::Format::EAC_R11_UNORM_BLOCK),
            ("eac_signed_r11", vk::Format::EAC_R11_SNORM_BLOCK),
            ("eac_rg11", vk::Format::EAC_R11G11_UNORM_BLOCK),
            ("eac_signed_rg11", vk::Format::EAC_R11G11_SNORM_BLOCK),
            ("etc2_rgb8", vk::Format::ETC2_R8G8B8_UNORM_BLOCK),
            ("etc2_srgb8", vk::Format::ETC2_R8G8B8_SRGB_BLOCK),
            ("etc2_rgb8_punchthrough_alpha1", vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK),
            ("etc2_srgb8_punchthrough_alpha1", vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK),
            ("etc2_eac_rgba8", vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK),
            ("etc2_eac_srgb8_alpha8", vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK),
        ];

        for &(format_name, format) in &ETC2_FORMATS {
            let mut format_group = TestCaseGroup::new(format_name);
            for &(size_name, width, height) in &[("pot", 64, 128), ("npot", 123, 107)] {
                add_wrap_cases(&mut format_group, Source::Compressed(format), width, height, size_name);
            }
            group.add_child(format_group);
        }
    }

    // ASTC cases, in upstream's `CompressedTexFormat` order (4x4 .. 12x12, linear then sRGB per size).
    {
        const ASTC_FORMATS: [(i32, i32, vk::Format, vk::Format); 14] = [
            (4, 4, vk::Format::ASTC_4X4_UNORM_BLOCK, vk::Format::ASTC_4X4_SRGB_BLOCK),
            (5, 4, vk::Format::ASTC_5X4_UNORM_BLOCK, vk::Format::ASTC_5X4_SRGB_BLOCK),
            (5, 5, vk::Format::ASTC_5X5_UNORM_BLOCK, vk::Format::ASTC_5X5_SRGB_BLOCK),
            (6, 5, vk::Format::ASTC_6X5_UNORM_BLOCK, vk::Format::ASTC_6X5_SRGB_BLOCK),
            (6, 6, vk::Format::ASTC_6X6_UNORM_BLOCK, vk::Format::ASTC_6X6_SRGB_BLOCK),
            (8, 5, vk::Format::ASTC_8X5_UNORM_BLOCK, vk::Format::ASTC_8X5_SRGB_BLOCK),
            (8, 6, vk::Format::ASTC_8X6_UNORM_BLOCK, vk::Format::ASTC_8X6_SRGB_BLOCK),
            (8, 8, vk::Format::ASTC_8X8_UNORM_BLOCK, vk::Format::ASTC_8X8_SRGB_BLOCK),
            (
                10,
                5,
                vk::Format::ASTC_10X5_UNORM_BLOCK,
                vk::Format::ASTC_10X5_SRGB_BLOCK,
            ),
            (
                10,
                6,
                vk::Format::ASTC_10X6_UNORM_BLOCK,
                vk::Format::ASTC_10X6_SRGB_BLOCK,
            ),
            (
                10,
                8,
                vk::Format::ASTC_10X8_UNORM_BLOCK,
                vk::Format::ASTC_10X8_SRGB_BLOCK,
            ),
            (
                10,
                10,
                vk::Format::ASTC_10X10_UNORM_BLOCK,
                vk::Format::ASTC_10X10_SRGB_BLOCK,
            ),
            (
                12,
                10,
                vk::Format::ASTC_12X10_UNORM_BLOCK,
                vk::Format::ASTC_12X10_SRGB_BLOCK,
            ),
            (
                12,
                12,
                vk::Format::ASTC_12X12_UNORM_BLOCK,
                vk::Format::ASTC_12X12_SRGB_BLOCK,
            ),
        ];

        for &(block_x, block_y, linear, srgb) in &ASTC_FORMATS {
            for (format, is_srgb) in [(linear, false), (srgb, true)] {
                let format_name = format!("astc_{block_x}x{block_y}{}", if is_srgb { "_srgb" } else { "" });
                let mut format_group = TestCaseGroup::new(&format_name);

                let format_sizes = [
                    ("divisible", block_x * 10, block_y * 10),
                    ("not_divisible", block_x * 10 + 1, block_y * 10 + 1),
                ];
                for &(size_name, width, height) in &format_sizes {
                    add_wrap_cases(&mut format_group, Source::Compressed(format), width, height, size_name);
                }
                group.add_child(format_group);
            }
        }
    }

    group
}
