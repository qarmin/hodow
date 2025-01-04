// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fCompressedTextureTests.cpp
//   modules/gles3/functional/es3fASTCDecompressionCases.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each upstream case is re-entered through
// `iterate` once per image (CONTINUE/STOP); here `iterate` loops over those images itself and
// reports the first failure. Formats are `vk::Format` rather than `tcu::CompressedTexFormat`
// (the crate's convention), and so is the `glu::Texture2D` compressed constructor, which
// always decodes the reference as LDR: for a driver reporting HDR ASTC support and a
// non-sRGB format the reference level is decoded again in HDR mode (`redecode_hdr`).
// Image logging is dropped; a failure's message carries the first failing block's column,
// row and hex dump instead. 2D formats only, as upstream's `isAstcFormat` list.

use vulkanalia::vk;

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d, get_sampler_type};
use crate::glu::texture_test_util_surface::{compare_images, make_reference_params, sample_texture_2d_to_surface};
use crate::glu::{Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::astc::{
    BLOCK_SIZE_BYTES, BlockTestType, decompress_block_to, generate_block_case_test_data,
    generate_default_normal_blocks, generate_default_void_extent_blocks,
};
use crate::tcu::compressed_texture::get_uncompressed_format;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::texture::TextureFormat;
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, de_string_hash};
use crate::vk::compressed_formats::{get_block_height, get_block_width, is_astc_srgb_format};

/// `ASTCBlockSizeRemainderCase2D::MAX_NUM_BLOCKS_X` / `_Y`
const MAX_NUM_BLOCKS_X: i32 = 5;
const MAX_NUM_BLOCKS_Y: i32 = 5;

/// (block width, block height, UNORM format, sRGB format), in upstream's block-size order.
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

/// `getASTCFormatShortName`
fn astc_format_short_name(format: vk::Format) -> String {
    let (width, height) = (get_block_width(format), get_block_height(format));
    format!(
        "{width}x{height}{}",
        if is_astc_srgb_format(format) { "_srgb" } else { "" }
    )
}

/// Every ASTC format in `tcu::CompressedTexFormat` order: all RGBA8 ones, then all sRGB8_ALPHA8 ones.
fn astc_formats_in_enum_order() -> Vec<vk::Format> {
    ASTC_FORMATS
        .iter()
        .map(|f| f.2)
        .chain(ASTC_FORMATS.iter().map(|f| f.3))
        .collect()
}

/// `astcBlockDataStr`
fn astc_block_data_str(data: &[u8]) -> String {
    let mut result = String::new();
    result += "  Hexadecimal (big endian: upper left hex digit is block bits 127 to 124):";

    {
        const HEX_DIGITS: &[u8; 16] = b"0123456789ABCDEF";

        for i in (0..BLOCK_SIZE_BYTES).rev() {
            if (i + 1) % 2 == 0 {
                result += "\n    ";
            } else {
                result += "  ";
            }

            result.push(HEX_DIGITS[((data[i] & 0xf0) >> 4) as usize] as char);
            result += " ";
            result.push(HEX_DIGITS[(data[i] & 0x0f) as usize] as char);
        }
    }

    result += "\n\n  Binary (big endian: upper left bit is block bit 127):";

    for i in (0..BLOCK_SIZE_BYTES).rev() {
        if (i + 1) % 2 == 0 {
            result += "\n    ";
        } else {
            result += "  ";
        }

        for j in (0..8).rev() {
            if j == 3 {
                result += " ";
            }

            result += if (data[i] >> j) & 1 != 0 { "1" } else { "0" };
        }
    }

    result += "\n";

    result
}

struct BlockCompare {
    ok: bool,
    first_failed_block: (i32, i32),
    max_diff: [i32; 4],
}

/// `compareBlockImages` - compare reference and result block images, reporting also the
/// position of the first non-matching block.
fn compare_block_images(
    reference: &Surface,
    result: &Surface,
    threshold: RGBA,
    block_size: (i32, i32),
    num_used_blocks: i32,
) -> BlockCompare {
    debug_assert!(reference.get_width() == result.get_width() && reference.get_height() == result.get_height());

    let width = result.get_width();
    let height = result.get_height();
    let threshold = [
        threshold.get_red(),
        threshold.get_green(),
        threshold.get_blue(),
        threshold.get_alpha(),
    ];
    let num_x_blocks = width / block_size.0;

    debug_assert!(width % block_size.0 == 0 && height % block_size.1 == 0);

    let mut first_failed_block = (-1, -1);
    let mut max_diff = [0i32; 4];

    for y in 0..height {
        for x in 0..width {
            let block_coord = (x / block_size.0, y / block_size.1);

            if block_coord.1 * num_x_blocks + block_coord.0 < num_used_blocks {
                let ref_pixel = reference.get_pixel(x, y);
                let ref_pix = [
                    ref_pixel.get_red(),
                    ref_pixel.get_green(),
                    ref_pixel.get_blue(),
                    ref_pixel.get_alpha(),
                ];

                if ref_pix == [255, 0, 255, 255] {
                    // ASTC error color - allow anything in result.
                    continue;
                }

                let res_pixel = result.get_pixel(x, y);
                let res_pix = [
                    res_pixel.get_red(),
                    res_pixel.get_green(),
                    res_pixel.get_blue(),
                    res_pixel.get_alpha(),
                ];
                let diff: [i32; 4] = std::array::from_fn(|i| (ref_pix[i] - res_pix[i]).abs());
                let is_ok = (0..4).all(|i| diff[i] <= threshold[i]);

                for i in 0..4 {
                    max_diff[i] = max_diff[i].max(diff[i]);
                }

                if !is_ok && first_failed_block.0 == -1 {
                    first_failed_block = block_coord;
                }
            }
        }
    }

    BlockCompare {
        ok: (0..4).all(|i| max_diff[i] <= threshold[i]),
        first_failed_block,
        max_diff,
    }
}

/// `ASTCSupportLevel` - ordered from smallest subset to full, for convenient comparison.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum AstcSupportLevel {
    None,
    Ldr,
    Hdr,
    Full,
}

/// `getASTCSupportLevel`
fn get_astc_support_level(context: &Context) -> AstcSupportLevel {
    let is_es32 = context.context_type().supports(3, 2);
    let mut max_level = AstcSupportLevel::None;

    for ext in &context.context_info.extensions {
        let ext = ext.as_str();
        let level = if is_es32 {
            if ext == "GL_KHR_texture_compression_astc_hdr" {
                AstcSupportLevel::Hdr
            } else if ext == "GL_OES_texture_compression_astc" {
                AstcSupportLevel::Full
            } else {
                AstcSupportLevel::Ldr
            }
        } else if ext == "GL_KHR_texture_compression_astc_ldr" {
            AstcSupportLevel::Ldr
        } else if ext == "GL_KHR_texture_compression_astc_hdr" {
            AstcSupportLevel::Hdr
        } else if ext == "GL_OES_texture_compression_astc" {
            AstcSupportLevel::Full
        } else {
            AstcSupportLevel::None
        };
        max_level = max_level.max(level);
    }

    max_level
}

/// Decodes `data` (the whole image's blocks) into `texture`'s level 0 in HDR mode, replacing
/// the LDR decode `Texture2D::new_compressed` made.
fn redecode_hdr(texture: &mut Texture2D<'_>, format: vk::Format, data: &[u8], width: i32, height: i32) {
    let (block_width, block_height) = (get_block_width(format) as i32, get_block_height(format) as i32);
    let num_blocks_x = (width + block_width - 1) / block_width;
    let num_blocks_y = (height + block_height - 1) / block_height;
    let uncompressed = get_uncompressed_format(format).expect("ASTC formats always have an uncompressed format");
    let mut level = texture.ref_texture_mut().level_mut(0);

    for block_y in 0..num_blocks_y {
        for block_x in 0..num_blocks_x {
            let block = &data[((block_y * num_blocks_x + block_x) as usize) * BLOCK_SIZE_BYTES..][..BLOCK_SIZE_BYTES];
            let mut tmp = TextureLevel::new(uncompressed, block_width as u32, block_height as u32, 1)
                .expect("the decoded format is writable");
            decompress_block_to(&mut tmp.get_access(), block, false, false);

            let tmp_access = tmp.get_const_access();
            for y in 0..block_height {
                for x in 0..block_width {
                    let (dst_x, dst_y) = (block_x * block_width + x, block_y * block_height + y);
                    if dst_x < width && dst_y < height {
                        level.set_pixel(
                            tmp_access.get_pixel(x as u32, y as u32, 0),
                            dst_x as u32,
                            dst_y as u32,
                            0,
                        );
                    }
                }
            }
        }
    }
}

/// `ASTCRenderer2D` - the common rendering stuff of ASTC cases.
struct AstcRenderer2D<'gl> {
    renderer: TextureRenderer<'gl>,
    block_size: (i32, i32),
    astc_support: AstcSupportLevel,
    color_scale: [f32; 4],
    color_bias: [f32; 4],
    rnd: Random,
}

impl<'gl> AstcRenderer2D<'gl> {
    fn new(context: &'gl Context, format: vk::Format, random_seed: u32) -> Self {
        Self {
            renderer: TextureRenderer::new(&context.render_context, GlslVersion::Es300, Precision::HighP),
            block_size: (get_block_width(format) as i32, get_block_height(format) as i32),
            astc_support: AstcSupportLevel::None,
            color_scale: [-1.0; 4],
            color_bias: [-1.0; 4],
            rnd: Random::new(random_seed),
        }
    }

    /// `ASTCRenderer2D::initialize`
    fn initialize(
        &mut self,
        context: &Context,
        min_render_width: i32,
        min_render_height: i32,
        color_scale: [f32; 4],
        color_bias: [f32; 4],
    ) -> Result<(), TestError> {
        let render_target = context.render_target();

        self.astc_support = get_astc_support_level(context);
        self.color_scale = color_scale;
        self.color_bias = color_bias;

        if self.astc_support == AstcSupportLevel::None {
            return Err(TestError::NotSupported("ASTC not supported".to_string()));
        }

        if render_target.width < min_render_width || render_target.height < min_render_height {
            return Err(TestError::NotSupported(format!(
                "Render target must be at least {min_render_width}x{min_render_height}"
            )));
        }

        Ok(())
    }

    /// `decompressionMode`: LDR unless the driver has HDR support and the format is not sRGB.
    fn is_ldr_decode(&self, format: vk::Format) -> bool {
        self.astc_support == AstcSupportLevel::Ldr || is_astc_srgb_format(format)
    }

    /// `ASTCRenderer2D::render`
    fn render(
        &mut self,
        context: &Context,
        reference_dst: &mut Surface,
        result_dst: &mut Surface,
        texture: &Texture2D<'_>,
        uncompressed_format: TextureFormat,
    ) -> Result<(), TestError> {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let texture_width = texture.ref_texture().width() as i32;
        let texture_height = texture.ref_texture().height() as i32;
        let viewport = RandomViewport::new(&render_target, texture_width, texture_height, self.rnd.get_uint32());
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let mut render_params = make_reference_params(
            TextureType::Texture2D,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_NEAREST,
            glw::GL_NEAREST,
            LodMode::Exact,
        )?;
        render_params.base.sampler_type = get_sampler_type(uncompressed_format);
        render_params.base.color_scale = Vec4::new(
            self.color_scale[0],
            self.color_scale[1],
            self.color_scale[2],
            self.color_scale[3],
        );
        render_params.base.color_bias = Vec4::new(
            self.color_bias[0],
            self.color_bias[1],
            self.color_bias[2],
            self.color_bias[3],
        );

        // SAFETY: plain state setting on the current context.
        unsafe {
            // Setup base viewport.
            gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);

            // Bind to unit 0.
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());

            // Setup nearest neighbor filtering and clamp-to-edge.
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        }
        crate::glu::expect_no_error(gl, "Set texturing state")?;

        // Issue GL draws.
        self.renderer.render_quad(0, &tex_coord, &render_params.base)?;
        // SAFETY: plain call on the current context.
        unsafe { gl.flush() };

        // Compute reference.
        let mut dst = SurfaceAccess::new(reference_dst, render_target.pixel_format());
        sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

        // Read GL-rendered image.
        read_pixels(render_ctx, viewport.x, viewport.y, &mut result_dst.get_access())?;
        Ok(())
    }
}

/// The threshold both cases use: the render target's own, plus 2 for sRGB and 1 otherwise.
fn comparison_threshold(context: &Context, format: vk::Format) -> RGBA {
    context.render_target().pixel_format().get_color_threshold()
        + if is_astc_srgb_format(format) {
            RGBA::new(2, 2, 2, 2)
        } else {
            RGBA::new(1, 1, 1, 1)
        }
}

/// Builds the compressed texture for `data`, decoded and uploaded the way `glu::Texture2D(...,
/// TexDecompressionParams(mode))` does.
fn make_compressed_texture<'gl>(
    context: &'gl Context,
    format: vk::Format,
    width: i32,
    height: i32,
    data: &[u8],
    is_ldr_decode: bool,
) -> Result<Texture2D<'gl>, TestError> {
    let mut texture = Texture2D::new_compressed(
        &context.render_context,
        &context.context_info,
        format,
        width as u32,
        height as u32,
        &[data],
    )?;
    if !is_ldr_decode {
        redecode_hdr(&mut texture, format, data, width, height);
    }
    // SAFETY: a current context; `texture` outlives the upload.
    unsafe { texture.upload_compressed()? };
    Ok(texture)
}

/// `ASTCBlockCase2D`
struct AstcBlockCase2D {
    name: String,
    test_type: BlockTestType,
    format: vk::Format,
}

impl TestCase for AstcBlockCase2D {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        debug_assert!(!(is_astc_srgb_format(self.format) && self.test_type.is_hdr_only()));

        // `init`
        let mut renderer = AstcRenderer2D::new(context, self.format, de_string_hash(&self.name));
        renderer.initialize(
            context,
            64,
            64,
            self.test_type.color_scale(),
            self.test_type.color_bias(),
        )?;

        let (block_width, block_height) = renderer.block_size;
        let block_data = generate_block_case_test_data(block_width, block_height, self.test_type);
        debug_assert!(!block_data.is_empty());
        debug_assert!(block_data.len().is_multiple_of(BLOCK_SIZE_BYTES));

        // `iterate`
        if renderer.astc_support == AstcSupportLevel::Ldr && self.test_type.is_hdr_only() {
            // Passing the case immediately, since only LDR support was detected and the test only contains HDR blocks.
            return Ok(TestStatus::pass("Pass"));
        }

        let render_target = context.render_target();
        let threshold = comparison_threshold(context, self.format);
        let total_num_blocks = (block_data.len() / BLOCK_SIZE_BYTES) as i32;
        let num_x_blocks_per_image = render_target.width.min(512) / block_width;
        let num_y_blocks_per_image = render_target.height.min(512) / block_height;
        let num_blocks_per_image = num_x_blocks_per_image * num_y_blocks_per_image;
        let image_width = num_x_blocks_per_image * block_width;
        let image_height = num_y_blocks_per_image * block_height;
        let uncompressed_format = get_uncompressed_format(self.format)
            .ok_or_else(|| TestError::Fail("no uncompressed format".to_string()))?;
        let is_ldr_decode = renderer.is_ldr_decode(self.format);

        let mut num_blocks_tested = 0;
        while num_blocks_tested < total_num_blocks {
            let num_blocks_remaining = total_num_blocks - num_blocks_tested;
            let cur_num_used_blocks = num_blocks_per_image.min(num_blocks_remaining);
            let cur_num_unused_blocks = num_blocks_per_image - cur_num_used_blocks;

            let mut compressed = vec![0u8; num_blocks_per_image as usize * BLOCK_SIZE_BYTES];
            let used_bytes = cur_num_used_blocks as usize * BLOCK_SIZE_BYTES;
            let src_start = num_blocks_tested as usize * BLOCK_SIZE_BYTES;
            compressed[..used_bytes].copy_from_slice(&block_data[src_start..src_start + used_bytes]);
            if cur_num_used_blocks > 1 {
                generate_default_void_extent_blocks(&mut compressed[used_bytes..], cur_num_unused_blocks as usize);
            }

            // Create texture and render.
            let texture = make_compressed_texture(
                context,
                self.format,
                image_width,
                image_height,
                &compressed,
                is_ldr_decode,
            )?;
            let mut rendered_frame = Surface::new(image_width, image_height);
            let mut reference_frame = Surface::new(image_width, image_height);

            renderer.render(
                context,
                &mut reference_frame,
                &mut rendered_frame,
                &texture,
                uncompressed_format,
            )?;

            // Compare.
            let compare = compare_block_images(
                &reference_frame,
                &rendered_frame,
                threshold,
                (block_width, block_height),
                cur_num_used_blocks,
            );
            if !compare.ok {
                let block_ndx = num_blocks_tested
                    + compare.first_failed_block.1 * num_x_blocks_per_image
                    + compare.first_failed_block.0;
                debug_assert!(block_ndx < total_num_blocks);
                let block_start = block_ndx as usize * BLOCK_SIZE_BYTES;

                return Ok(TestStatus::fail(format!(
                    "Image comparison failed: max difference = {:?}, threshold = ({}, {}, {}, {}); first failed block at column {} and row {}; data of first failed block:\n{}",
                    compare.max_diff,
                    threshold.get_red(),
                    threshold.get_green(),
                    threshold.get_blue(),
                    threshold.get_alpha(),
                    compare.first_failed_block.0,
                    compare.first_failed_block.1,
                    astc_block_data_str(&block_data[block_start..block_start + BLOCK_SIZE_BYTES])
                )));
            }

            num_blocks_tested += cur_num_used_blocks;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ASTCBlockSizeRemainderCase2D`
struct AstcBlockSizeRemainderCase2D {
    name: String,
    format: vk::Format,
}

impl TestCase for AstcBlockSizeRemainderCase2D {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // `init`
        let mut renderer = AstcRenderer2D::new(context, self.format, de_string_hash(&self.name));
        let block_size = renderer.block_size;
        renderer.initialize(
            context,
            MAX_NUM_BLOCKS_X * block_size.0,
            MAX_NUM_BLOCKS_Y * block_size.1,
            [1.0; 4],
            [0.0; 4],
        )?;

        // `iterate`
        let threshold = comparison_threshold(context, self.format);
        let uncompressed_format = get_uncompressed_format(self.format)
            .ok_or_else(|| TestError::Fail("no uncompressed format".to_string()))?;
        let is_ldr_decode = renderer.is_ldr_decode(self.format);

        for current_iteration in 0..block_size.0 * block_size.1 {
            let cur_remainder_x = current_iteration % block_size.0;
            let cur_remainder_y = current_iteration / block_size.0;
            let image_width = (MAX_NUM_BLOCKS_X - 1) * block_size.0 + cur_remainder_x;
            let image_height = (MAX_NUM_BLOCKS_Y - 1) * block_size.1 + cur_remainder_y;
            let num_blocks_x = (image_width + block_size.0 - 1) / block_size.0;
            let num_blocks_y = (image_height + block_size.1 - 1) / block_size.1;
            let total_num_blocks = (num_blocks_x * num_blocks_y) as usize;

            let mut compressed = vec![0u8; total_num_blocks * BLOCK_SIZE_BYTES];
            generate_default_normal_blocks(&mut compressed, total_num_blocks);

            // Create texture and render.
            let mut rendered_frame = Surface::new(image_width, image_height);
            let mut reference_frame = Surface::new(image_width, image_height);
            let texture = make_compressed_texture(
                context,
                self.format,
                image_width,
                image_height,
                &compressed,
                is_ldr_decode,
            )?;

            renderer.render(
                context,
                &mut reference_frame,
                &mut rendered_frame,
                &texture,
                uncompressed_format,
            )?;

            // Compare.
            if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                return Ok(TestStatus::fail(format!(
                    "Image comparison failed (iteration {current_iteration}, remainder {cur_remainder_x}x{cur_remainder_y})"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `CompressedTextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("compressed");

    // ASTC cases.
    let mut astc_group = TestCaseGroup::new("astc");

    // Block test cases.
    for test_type in BlockTestType::ALL {
        let mut test_type_group = TestCaseGroup::new(test_type.name());

        for format in astc_formats_in_enum_order() {
            if is_astc_srgb_format(format) && test_type.is_hdr_only() {
                continue;
            }

            test_type_group.add_child(Box::new(AstcBlockCase2D {
                name: astc_format_short_name(format),
                test_type,
                format,
            }) as Box<dyn TestCase>);
        }

        astc_group.add_child(test_type_group);
    }

    // Image size/block size remainder cases.
    {
        let mut block_size_remainder_group = TestCaseGroup::new("block_size_remainder");

        for format in astc_formats_in_enum_order() {
            block_size_remainder_group.add_child(Box::new(AstcBlockSizeRemainderCase2D {
                name: astc_format_short_name(format),
                format,
            }) as Box<dyn TestCase>);
        }

        astc_group.add_child(block_size_remainder_group);
    }

    group.add_child(astc_group);
    group
}
