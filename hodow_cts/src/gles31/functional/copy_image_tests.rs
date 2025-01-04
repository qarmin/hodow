// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fCopyImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Narrowings against upstream:
// - `iterate()` here runs to completion, so the six `CONTINUE` iterations of
//   `CopyImageTest::iterate` are one sequential body, in the same order.
// - `tcu::TexDecompressionParams` has no counterpart: `tcu::compressed_texture::decompress`
//   always decodes ASTC in LDR mode, which is what upstream's default parameters select.
// - `tcu::SeedBuilder` is the CRC32 fed with the same values in the same order, but an
//   `IVec3` is fed as three 32-bit ints.
// - Only ES: `CopyImageTests(context, is_GL45 = false)`.

use std::ffi::c_void;

use vulkanalia::vk;

use crate::gls::texture_test_util::TextureRenderer;
use crate::glu::shader_util::Precision;
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, TextureType, compute_quad_tex_coord_2d, compute_quad_tex_coord_2d_array,
    compute_quad_tex_coord_3d, get_sampler_type, sample_texture_2d, sample_texture_2d_array, sample_texture_3d,
    sample_texture_cube,
};
use crate::glu::texture_util::{
    get_transfer_format, is_compressed_format, map_gl_compressed_tex_format, map_gl_internal_format,
};
use crate::glu::{self, Context, Framebuffer, Renderbuffer, TestCase, TestCaseGroup, Texture};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::{float_threshold_compare, float_ulp_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, FilterMode, MipmapFilterMode, PixelBufferAccess, Sampler, TextureLevel,
    get_texture_format_bit_depth, get_texture_format_info, srgb_to_linear,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::{Random, Surface, TestError, TestOutcome, UVec4, Vec2, Vec3, Vec4};
use crate::vk::compressed_formats::{
    get_block_depth, get_block_height, get_block_size_in_bytes, get_block_width, is_astc_format,
};

type V3 = [i32; 3];

fn v3_add(a: V3, b: V3) -> V3 {
    [a[0] + b[0], a[1] + b[1], a[2] + b[2]]
}

fn v3_sub(a: V3, b: V3) -> V3 {
    [a[0] - b[0], a[1] - b[1], a[2] - b[2]]
}

fn v3_mul(a: V3, b: V3) -> V3 {
    [a[0] * b[0], a[1] * b[1], a[2] * b[2]]
}

fn v3_div(a: V3, b: V3) -> V3 {
    [a[0] / b[0], a[1] / b[1], a[2] / b[2]]
}

fn v3_min(a: V3, b: V3) -> V3 {
    [a[0].min(b[0]), a[1].min(b[1]), a[2].min(b[2])]
}

fn v3_max(a: V3, b: V3) -> V3 {
    [a[0].max(b[0]), a[1].max(b[1]), a[2].max(b[2])]
}

/// `ViewClass`, with the names `viewClassToName` gives them.
#[derive(Clone, Copy)]
struct ViewClass(&'static str);

const VIEWCLASS_128_BITS: ViewClass = ViewClass("viewclass_128_bits");
const VIEWCLASS_96_BITS: ViewClass = ViewClass("viewclass_96_bits");
const VIEWCLASS_64_BITS: ViewClass = ViewClass("viewclass_64_bits");
const VIEWCLASS_48_BITS: ViewClass = ViewClass("viewclass_48_bits");
const VIEWCLASS_32_BITS: ViewClass = ViewClass("viewclass_32_bits");
const VIEWCLASS_24_BITS: ViewClass = ViewClass("viewclass_24_bits");
const VIEWCLASS_16_BITS: ViewClass = ViewClass("viewclass_16_bits");
const VIEWCLASS_8_BITS: ViewClass = ViewClass("viewclass_8_bits");

#[derive(Clone, Copy, PartialEq, Eq)]
enum Verify {
    None,
    CompareReference,
}

fn target_to_name(target: GLenum) -> &'static str {
    match target {
        glw::GL_RENDERBUFFER => "renderbuffer",
        glw::GL_TEXTURE_2D => "texture2d",
        glw::GL_TEXTURE_3D => "texture3d",
        glw::GL_TEXTURE_2D_ARRAY => "texture2d_array",
        glw::GL_TEXTURE_CUBE_MAP => "cubemap",
        other => panic!("unsupported copy image target {other:#x}"),
    }
}

/// The ASTC formats as `(RGBA, SRGB8_ALPHA8, block size)`, in the order the view classes list them.
const ASTC_FORMATS: [(GLenum, GLenum, &str); 14] = [
    (
        glw::GL_COMPRESSED_RGBA_ASTC_4x4,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4,
        "4x4",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_5x4,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4,
        "5x4",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_5x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5,
        "5x5",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_6x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5,
        "6x5",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_6x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6,
        "6x6",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_8x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5,
        "8x5",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_8x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6,
        "8x6",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_8x8,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8,
        "8x8",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_10x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5,
        "10x5",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_10x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6,
        "10x6",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_10x8,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8,
        "10x8",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_10x10,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10,
        "10x10",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_12x10,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10,
        "12x10",
    ),
    (
        glw::GL_COMPRESSED_RGBA_ASTC_12x12,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12,
        "12x12",
    ),
];

/// `glu::getCompressedTextureFormatStr` with the `GL_COMPRESSED_` prefix already stripped and lower-cased.
fn compressed_format_name(format: GLenum) -> String {
    for (rgba, srgb, size) in ASTC_FORMATS {
        if format == rgba {
            return format!("rgba_astc_{size}_khr");
        }
        if format == srgb {
            return format!("srgb8_alpha8_astc_{size}_khr");
        }
    }

    let name = match format {
        glw::GL_COMPRESSED_R11_EAC => "r11_eac",
        glw::GL_COMPRESSED_SIGNED_R11_EAC => "signed_r11_eac",
        glw::GL_COMPRESSED_RG11_EAC => "rg11_eac",
        glw::GL_COMPRESSED_SIGNED_RG11_EAC => "signed_rg11_eac",
        glw::GL_COMPRESSED_RGB8_ETC2 => "rgb8_etc2",
        glw::GL_COMPRESSED_SRGB8_ETC2 => "srgb8_etc2",
        glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 => "rgb8_punchthrough_alpha1_etc2",
        glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 => "srgb8_punchthrough_alpha1_etc2",
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC => "rgba8_etc2_eac",
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC => "srgb8_alpha8_etc2_eac",
        other => panic!("unnamed compressed format {other:#x}"),
    };
    name.to_string()
}

fn format_to_name(format: GLenum) -> String {
    if is_compressed_format(format) {
        compressed_format_name(format)
    } else {
        let name = glu::texture_format_name(format).unwrap_or_else(|| panic!("unnamed format {format:#x}"));
        name[3..].to_lowercase()
    }
}

fn uncompressed_tex_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format).ok_or_else(|| TestError::InternalError(format!("no tcu format for {format:#x}")))
}

fn compressed_tex_format(format: GLenum) -> Result<vk::Format, TestError> {
    map_gl_compressed_tex_format(format)
        .ok_or_else(|| TestError::InternalError(format!("no compressed format for {format:#x}")))
}

fn channel_class_of(format: GLenum) -> Option<TextureChannelClass> {
    if is_compressed_format(format) {
        return None;
    }
    map_gl_internal_format(format).map(|f| f.channel_class())
}

fn is_float_format(format: GLenum) -> bool {
    channel_class_of(format) == Some(TextureChannelClass::FloatingPoint)
}

fn is_uint_format(format: GLenum) -> bool {
    channel_class_of(format) == Some(TextureChannelClass::UnsignedInteger)
}

fn is_int_format(format: GLenum) -> bool {
    channel_class_of(format) == Some(TextureChannelClass::SignedInteger)
}

fn is_fixed_point_format(format: GLenum) -> bool {
    matches!(
        channel_class_of(format),
        Some(TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint)
    )
}

fn is_texture_target(target: GLenum) -> bool {
    target != glw::GL_RENDERBUFFER
}

fn get_target_tex_dims(target: GLenum) -> i32 {
    match target {
        glw::GL_TEXTURE_2D | glw::GL_TEXTURE_CUBE_MAP => 2,
        glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => 3,
        other => panic!("unsupported texture target {other:#x}"),
    }
}

fn log2_ceil(x: i32) -> i32 {
    if x <= 1 {
        0
    } else {
        32 - ((x - 1) as u32).leading_zeros() as i32
    }
}

/// `RandomizedRenderGrid`
struct RandomizedRenderGrid {
    target_size: [i32; 2],
    cell_size: [i32; 2],
    grid: [i32; 2],
    current_cell: i32,
    cell_count: i32,
    base_random_offset: [i32; 2],
}

impl RandomizedRenderGrid {
    fn new(target_size: [i32; 2], cell_size: [i32; 2], max_cell_count: i32, seed: u32) -> Self {
        let grid = [target_size[0] / cell_size[0], target_size[1] / cell_size[1]];
        // If the grid exactly fits height, take one row for randomization.
        let cell_count = max_cell_count.min(if (target_size[1] % cell_size[1]) == 0 && grid[1] > 1 {
            grid[0] * (grid[1] - 1)
        } else {
            grid[0] * grid[1]
        });
        let base_random_offset = Self::get_random_offset(seed, target_size, cell_size, grid, cell_count);
        Self {
            target_size,
            cell_size,
            grid,
            current_cell: 0,
            cell_count,
            base_random_offset,
        }
    }

    fn get_random_offset(
        seed: u32,
        target_size: [i32; 2],
        cell_size: [i32; 2],
        grid: [i32; 2],
        cell_count: i32,
    ) -> [i32; 2] {
        let mut rng = Random::new(seed);
        let mut extra_space = [
            target_size[0] - cell_size[0] * grid[0],
            target_size[1] - cell_size[1] * grid[1],
        ];

        // If there'll be unused rows, donate them into extra space.
        extra_space[1] += (grid[1] - (cell_count + grid[0] - 1) / grid[0]) * cell_size[1];

        let x = rng.get_int(0, extra_space[0]);
        let y = rng.get_int(0, extra_space[1]);
        [x, y]
    }

    fn next_cell(&mut self) -> bool {
        if self.current_cell >= self.cell_count {
            return false;
        }
        self.current_cell += 1;
        true
    }

    fn get_origin(&self) -> [i32; 2] {
        let grid_x = (self.current_cell - 1) % self.grid[0];
        let grid_y = (self.current_cell - 1) / self.grid[0];
        let origin = [
            grid_x * self.cell_size[0] + self.base_random_offset[0],
            grid_y * self.cell_size[1] + self.base_random_offset[1],
        ];
        debug_assert!(origin[0] >= 0 && origin[0] + self.cell_size[0] <= self.target_size[0]);
        debug_assert!(origin[1] >= 0 && origin[1] + self.cell_size[1] <= self.target_size[1]);
        origin
    }

    fn get_used_area_bounding_box(&self) -> [i32; 4] {
        let last_cell = [
            (self.current_cell + 1).min(self.grid[0]),
            (self.current_cell + self.grid[0] - 1) / self.grid[0],
        ];
        let size = [last_cell[0] * self.cell_size[0], last_cell[1] * self.cell_size[1]];
        [self.base_random_offset[0], self.base_random_offset[1], size[0], size[1]]
    }
}

/// `ImageInfo`
#[derive(Clone, Copy)]
struct ImageInfo {
    format: GLenum,
    target: GLenum,
    size: V3,
}

fn get_level_count(info: &ImageInfo) -> i32 {
    let size = info.size;
    match info.target {
        glw::GL_RENDERBUFFER => 1,
        glw::GL_TEXTURE_2D_ARRAY => log2_ceil(size[0].max(size[1])),
        _ => log2_ceil(size[0].max(size[1]).max(size[2])),
    }
}

fn get_level_size(target: GLenum, base_size: V3, level: i32) -> V3 {
    if target != glw::GL_TEXTURE_2D_ARRAY {
        [
            (base_size[0] >> level).max(1),
            (base_size[1] >> level).max(1),
            (base_size[2] >> level).max(1),
        ]
    } else {
        [
            (base_size[0] >> level).max(1),
            (base_size[1] >> level).max(1),
            base_size[2],
        ]
    }
}

/// `TextureImageIterator`
struct TextureImageIterator {
    level_image_count: i32,
    target: GLenum,
    base_size: V3,
    current_level: i32,
    level_size: V3,
    current_image: i32,
    level_count: i32,
}

impl TextureImageIterator {
    fn new(info: &ImageInfo, level_count: i32) -> Self {
        let level_size = get_level_size(info.target, info.size, 0);
        Self {
            level_image_count: if info.target == glw::GL_TEXTURE_CUBE_MAP {
                6
            } else {
                level_size[2]
            },
            target: info.target,
            base_size: info.size,
            current_level: 0,
            level_size,
            current_image: -1,
            level_count,
        }
    }

    fn has_next_image(&self) -> bool {
        self.current_level < self.level_count - 1 || self.current_image < self.level_image_count - 1
    }

    fn next_image(&mut self) -> bool {
        if !self.has_next_image() {
            return false;
        }

        self.current_image += 1;
        if self.current_image == self.level_image_count {
            self.current_level += 1;
            self.current_image = 0;

            self.level_size = get_level_size(self.target, self.base_size, self.current_level);
            self.level_image_count = if self.target == glw::GL_TEXTURE_CUBE_MAP {
                6
            } else {
                self.level_size[2]
            };
        }
        true
    }

    fn size(&self) -> [i32; 2] {
        [self.level_size[0], self.level_size[1]]
    }
}

fn get_texture_image_name(texture_target: GLenum, mip_level: i32, image_index: i32) -> String {
    let mut result = format!("Level{mip_level}");
    match texture_target {
        glw::GL_TEXTURE_2D => {}
        glw::GL_TEXTURE_3D => result.push_str(&format!("Slice{image_index}")),
        glw::GL_TEXTURE_CUBE_MAP => result.push_str(&format!("Face{image_index}")),
        glw::GL_TEXTURE_2D_ARRAY => result.push_str(&format!("Layer{image_index}")),
        other => panic!("unsupported texture target {other:#x}"),
    }
    result
}

fn get_texture_image_description(texture_target: GLenum, mip_level: i32, image_index: i32) -> String {
    let mut result = format!("level {mip_level}");
    match texture_target {
        glw::GL_TEXTURE_2D => {}
        glw::GL_TEXTURE_3D => result.push_str(&format!(" and Slice {image_index}")),
        glw::GL_TEXTURE_CUBE_MAP => result.push_str(&format!(" and Face {image_index}")),
        glw::GL_TEXTURE_2D_ARRAY => result.push_str(&format!(" and Layer {image_index}")),
        other => panic!("unsupported texture target {other:#x}"),
    }
    result
}

/// `computeQuadTexCoordCube`, indexed by the GL face order (+X, -X, +Y, -Y, +Z, -Z) that
/// `mapFaceNdxToFace` uses.
fn compute_quad_tex_coord_cube_gl_face(face_ndx: i32) -> [f32; 12] {
    match face_ndx {
        0 => [1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0],
        1 => [-1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0],
        2 => [-1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0],
        3 => [-1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0],
        4 => [-1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0],
        5 => [1.0, 1.0, -1.0, 1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0],
        other => panic!("{other} is not a cube face"),
    }
}

fn map_face_ndx_to_face(ndx: i32) -> GLenum {
    const CUBE_FACES: [GLenum; 6] = [
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ];
    CUBE_FACES[ndx as usize]
}

/// `computeQuadTexCoords`
fn compute_quad_tex_coords(target: GLenum, current_image: i32, level_image_count: i32) -> Vec<f32> {
    match target {
        glw::GL_TEXTURE_2D => compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0)).to_vec(),
        glw::GL_TEXTURE_3D => {
            let r = (current_image as f32 + 0.5) / level_image_count as f32;
            compute_quad_tex_coord_3d(Vec3::new(0.0, 0.0, r), Vec3::new(1.0, 1.0, r), [0, 1, 2]).to_vec()
        }
        glw::GL_TEXTURE_CUBE_MAP => compute_quad_tex_coord_cube_gl_face(current_image).to_vec(),
        glw::GL_TEXTURE_2D_ARRAY => {
            compute_quad_tex_coord_2d_array(current_image, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0)).to_vec()
        }
        other => panic!("unsupported texture target {other:#x}"),
    }
}

/// `CellContents`
struct CellContents {
    origin: [i32; 2],
    reference: Surface,
    name: String,
    description: String,
}

/// `getMoreRestrictiveFormat`
#[allow(clippy::if_same_then_else)]
fn get_more_restrictive_format(format_a: GLenum, format_b: GLenum) -> GLenum {
    let is_astc = |format: GLenum| {
        is_compressed_format(format) && map_gl_compressed_tex_format(format).is_some_and(is_astc_format)
    };

    if format_a == format_b {
        format_a
    } else if is_astc(format_a) {
        format_a
    } else if is_astc(format_b) {
        format_b
    } else if is_float_format(format_a) {
        format_a
    } else if is_float_format(format_b) {
        format_b
    } else if is_compressed_format(format_a) {
        format_a
    } else if is_compressed_format(format_b) {
        format_b
    } else {
        format_a
    }
}

fn get_texel_block_size(format: GLenum) -> Result<usize, TestError> {
    if is_compressed_format(format) {
        Ok(get_block_size_in_bytes(compressed_tex_format(format)?) as usize)
    } else {
        let tex_format = uncompressed_tex_format(format)?;
        tex_format
            .pixel_size()
            .map(|s| s as usize)
            .ok_or_else(|| TestError::InternalError("unsized texture format".to_string()))
    }
}

fn get_texel_block_pixel_size(format: GLenum) -> Result<V3, TestError> {
    if is_compressed_format(format) {
        let f = compressed_tex_format(format)?;
        Ok([
            get_block_width(f) as i32,
            get_block_height(f) as i32,
            get_block_depth(f) as i32,
        ])
    } else {
        Ok([1, 1, 1])
    }
}

fn is_color_renderable(format: GLenum) -> bool {
    matches!(
        format,
        glw::GL_R8
            | glw::GL_RG8
            | glw::GL_RGB8
            | glw::GL_RGB565
            | glw::GL_RGB4
            | glw::GL_RGB5_A1
            | glw::GL_RGBA8
            | glw::GL_RGB10_A2
            | glw::GL_RGB10_A2UI
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_R8I
            | glw::GL_R8UI
            | glw::GL_R16I
            | glw::GL_R16UI
            | glw::GL_R32I
            | glw::GL_R32UI
            | glw::GL_RG8I
            | glw::GL_RG8UI
            | glw::GL_RG16I
            | glw::GL_RG16UI
            | glw::GL_RG32I
            | glw::GL_RG32UI
            | glw::GL_RGBA8I
            | glw::GL_RGBA8UI
            | glw::GL_RGBA16I
            | glw::GL_RGBA16UI
            | glw::GL_RGBA32I
            | glw::GL_RGBA32UI
    )
}

fn get_type_for_internal_format(format: GLenum) -> Result<GLenum, TestError> {
    Ok(get_transfer_format(uncompressed_tex_format(format)?)?.data_type)
}

fn get_format_for_internal_format(format: GLenum) -> Result<GLenum, TestError> {
    Ok(get_transfer_format(uncompressed_tex_format(format)?)?.format)
}

/// `genTexel` - `buffer` holds exactly `texel_block_size * texel_count` bytes.
fn gen_texel(
    rng: &mut Random,
    gl_format: GLenum,
    texel_block_size: usize,
    texel_count: usize,
    buffer: &mut [u8],
) -> Result<(), TestError> {
    if is_float_format(gl_format) {
        let format = uncompressed_tex_format(gl_format)?;
        let info = get_texture_format_info(format);
        let mut access = PixelBufferAccess::new(format, [texel_count as u32, 1, 1], buffer);

        for texel_ndx in 0..texel_count {
            let red = rng.get_float_range(info.value_min[0], info.value_max[0]);
            let green = rng.get_float_range(info.value_min[1], info.value_max[1]);
            let blue = rng.get_float_range(info.value_min[2], info.value_max[2]);
            let alpha = rng.get_float_range(info.value_min[3], info.value_max[3]);

            access.set_pixel([red, green, blue, alpha], texel_ndx as u32, 0, 0);
        }
    } else if is_compressed_format(gl_format) && is_astc_format(compressed_tex_format(gl_format)?) {
        const BLOCK_SIZE: usize = 16;
        // All of the following blocks are valid in LDR mode.
        const BLOCKS: [[u8; BLOCK_SIZE]; 8] = [
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

        debug_assert_eq!(texel_block_size, BLOCK_SIZE);

        for i in 0..texel_count {
            let block_ndx = rng.get_int(0, BLOCKS.len() as i32 - 1) as usize;
            buffer[i * BLOCK_SIZE..(i + 1) * BLOCK_SIZE].copy_from_slice(&BLOCKS[block_ndx]);
        }
    } else {
        for byte in buffer.iter_mut().take(texel_block_size * texel_count) {
            *byte = rng.get_uint8();
        }
    }
    Ok(())
}

fn div_round_up(a: V3, b: V3) -> V3 {
    std::array::from_fn(|i| a[i] / b[i] + i32::from(a[i] % b[i] != 0))
}

/// `genericTexImage`
fn generic_tex_image(
    gl: &glw::Functions,
    target: GLenum,
    face_ndx: i32,
    level: i32,
    size: V3,
    format: GLenum,
    data: &[u8],
) -> Result<(), TestError> {
    let gl_target = if target == glw::GL_TEXTURE_CUBE_MAP {
        map_face_ndx_to_face(face_ndx)
    } else {
        target
    };
    let ptr = data.as_ptr() as *const c_void;

    if is_compressed_format(format) {
        match get_target_tex_dims(target) {
            2 => {
                // SAFETY: `data` is exactly the compressed size of this level, which is `image_size`.
                unsafe {
                    gl.compressed_tex_image_2d(gl_target, level, format, size[0], size[1], 0, data.len() as i32, ptr)
                };
                glu::expect_no_error(gl, "glCompressedTexImage2D failed.")?;
            }
            3 => {
                // SAFETY: as above.
                unsafe {
                    gl.compressed_tex_image_3d(
                        gl_target,
                        level,
                        format,
                        size[0],
                        size[1],
                        size[2],
                        0,
                        data.len() as i32,
                        ptr,
                    )
                };
                glu::expect_no_error(gl, "glCompressedTexImage3D failed.")?;
            }
            other => panic!("unexpected texture dimensionality {other}"),
        }
    } else {
        let gl_format = get_format_for_internal_format(format)?;
        let gl_type = get_type_for_internal_format(format)?;

        match get_target_tex_dims(target) {
            2 => {
                // SAFETY: `data` is a tightly packed level of `format`, with UNPACK_ALIGNMENT 1.
                unsafe {
                    gl.tex_image_2d(
                        gl_target,
                        level,
                        format as i32,
                        size[0],
                        size[1],
                        0,
                        gl_format,
                        gl_type,
                        ptr,
                    )
                };
                glu::expect_no_error(gl, "glTexImage2D failed.")?;
            }
            3 => {
                // SAFETY: as above.
                unsafe {
                    gl.tex_image_3d(
                        gl_target,
                        level,
                        format as i32,
                        size[0],
                        size[1],
                        size[2],
                        0,
                        gl_format,
                        gl_type,
                        ptr,
                    )
                };
                glu::expect_no_error(gl, "glTexImage3D failed.")?;
            }
            other => panic!("unexpected texture dimensionality {other}"),
        }
    }
    Ok(())
}

/// `genTextureImage`
fn gen_texture_image(
    gl: &glw::Functions,
    rng: &mut Random,
    name: GLuint,
    levels: &mut Vec<Vec<u8>>,
    info: &ImageInfo,
    more_restrictive_format: GLenum,
) -> Result<(), TestError> {
    let texel_block_size = get_texel_block_size(info.format)?;
    let texel_block_pixel_size = get_texel_block_pixel_size(info.format)?;

    levels.clear();
    levels.resize(get_level_count(info) as usize, Vec::new());

    // SAFETY: plain state setting and a bind of the name this case generated.
    unsafe {
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
    }
    glu::expect_no_error(gl, "Setting pixel store aligment failed.")?;

    // SAFETY: as above.
    unsafe { gl.bind_texture(info.target, name) };
    glu::expect_no_error(gl, "Binding texture failed.")?;

    for level_ndx in 0..get_level_count(info) {
        let face_count = if info.target == glw::GL_TEXTURE_CUBE_MAP { 6 } else { 1 };

        let level_pixel_size = get_level_size(info.target, info.size, level_ndx);
        let level_texel_block_size = div_round_up(level_pixel_size, texel_block_pixel_size);
        let level_texel_block_count =
            (level_texel_block_size[0] * level_texel_block_size[1] * level_texel_block_size[2]) as usize;
        let level_size = level_texel_block_count * texel_block_size;

        let level = &mut levels[level_ndx as usize];
        level.resize(level_size * face_count, 0);

        for face_ndx in 0..face_count {
            let face = &mut level[face_ndx * level_size..(face_ndx + 1) * level_size];
            gen_texel(
                rng,
                more_restrictive_format,
                texel_block_size,
                level_texel_block_count,
                face,
            )?;
            generic_tex_image(
                gl,
                info.target,
                face_ndx as i32,
                level_ndx,
                level_pixel_size,
                info.format,
                face,
            )?;
        }
    }

    // SAFETY: the texture bound above.
    unsafe {
        gl.tex_parameteri(info.target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(info.target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);

        if info.target == glw::GL_TEXTURE_3D {
            gl.tex_parameteri(info.target, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
        }

        gl.tex_parameteri(info.target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(info.target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }
    glu::expect_no_error(gl, "Setting texture parameters failed")?;

    // SAFETY: unbinding.
    unsafe { gl.bind_texture(info.target, 0) };
    glu::expect_no_error(gl, "Unbinding texture failed.")
}

/// `genRenderbufferImage`
fn gen_renderbuffer_image(
    gl: &glw::Functions,
    rng: &mut Random,
    name: GLuint,
    levels: &mut Vec<Vec<u8>>,
    info: &ImageInfo,
    more_restrictive_format: GLenum,
) -> Result<(), TestError> {
    let size = info.size;
    let format = uncompressed_tex_format(info.format)?;
    let pixel_size = format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("unsized renderbuffer format".to_string()))?
        as usize;

    let framebuffer = Framebuffer::new(gl);

    levels.clear();
    levels.push(vec![0u8; pixel_size * size[0] as usize * size[1] as usize]);

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, name);
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, info.format, size[0], size[1]);
    }
    glu::expect_no_error(gl, "Binding and setting storage for renderbuffer failed.")?;

    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            name,
        );
    }
    glu::expect_no_error(gl, "Binding framebuffer and attaching renderbuffer failed.")?;

    {
        let mut texel_block = vec![0u8; pixel_size];

        if is_fixed_point_format(info.format) {
            // All zeroes is only bit pattern that fixed point values can be
            // cleared to and that is valid floating point value.
            if is_float_format(more_restrictive_format) {
                texel_block.fill(0x0);
            } else {
                // Fixed point values can be only cleared to all 0 or 1.
                let fill = if rng.get_bool() { 0xFF } else { 0x0 };
                texel_block.fill(fill);
            }
        } else {
            gen_texel(rng, more_restrictive_format, pixel_size, 1, &mut texel_block)?;
        }

        let texel_access = ConstPixelBufferAccess::new(format, [1, 1, 1], &texel_block);
        let mut ref_access = PixelBufferAccess::new(format, [size[0] as u32, size[1] as u32, 1], &mut levels[0]);

        if is_int_format(info.format) || is_uint_format(info.format) {
            let color = texel_access.get_pixel_int(0, 0, 0);

            // SAFETY: one four-component colour of output for draw buffer 0.
            unsafe {
                if is_int_format(info.format) {
                    gl.clear_bufferiv(glw::GL_COLOR, 0, color.as_ptr());
                } else {
                    gl.clear_bufferuiv(glw::GL_COLOR, 0, color.as_ptr() as *const GLuint);
                }
            }
            glu::expect_no_error(gl, "Failed to clear renderbuffer.")?;

            for y in 0..size[1] as u32 {
                for x in 0..size[0] as u32 {
                    let _ = ref_access.set_pixel_int(color, x, y, 0);
                }
            }
        } else {
            let raw_color = texel_access.get_pixel(0, 0, 0);
            let linear_color = if format.order.is_srgb() {
                srgb_to_linear(raw_color)
            } else {
                raw_color
            };

            // rawColor bit pattern has been chosen to be "safe" in the destination format. For sRGB
            // formats, the clear color is in linear space. Since we want the resulting bit pattern
            // to be safe after implementation linear->sRGB transform, we must apply the inverting
            // transform to the clear color.
            // SAFETY: one four-component colour of output for draw buffer 0.
            unsafe {
                if is_float_format(info.format) {
                    gl.clear_bufferfv(glw::GL_COLOR, 0, linear_color.as_ptr());
                } else {
                    gl.clear_color(linear_color[0], linear_color[1], linear_color[2], linear_color[3]);
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                }
            }
            glu::expect_no_error(gl, "Failed to clear renderbuffer.")?;

            for y in 0..size[1] as u32 {
                for x in 0..size[0] as u32 {
                    ref_access.set_pixel(raw_color, x, y, 0);
                }
            }
        }
    }

    // SAFETY: unbinding.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    glu::expect_no_error(gl, "Failed to unbind renderbufer and framebuffer.")
}

/// `glu::ObjectWrapper` over a texture or a renderbuffer.
enum ImageObject<'gl> {
    Texture(Texture<'gl>),
    Renderbuffer(Renderbuffer<'gl>),
}

impl ImageObject<'_> {
    fn get(&self) -> GLuint {
        match self {
            Self::Texture(t) => t.get(),
            Self::Renderbuffer(r) => r.get(),
        }
    }
}

/// `genImage`
fn gen_image(
    gl: &glw::Functions,
    rng: &mut Random,
    name: GLuint,
    levels: &mut Vec<Vec<u8>>,
    info: &ImageInfo,
    more_restrictive_format: GLenum,
) -> Result<(), TestError> {
    if is_texture_target(info.target) {
        gen_texture_image(gl, rng, name, levels, info, more_restrictive_format)
    } else {
        gen_renderbuffer_image(gl, rng, name, levels, info, more_restrictive_format)
    }
}

/// `getTexelBlockStride`
fn get_texel_block_stride(info: &ImageInfo, level: i32) -> Result<V3, TestError> {
    let size = get_level_size(info.target, info.size, level);
    let texel_block_size = get_texel_block_size(info.format)? as i32;
    let texel_block_pixel_size = get_texel_block_pixel_size(info.format)?;
    let texture_texel_block_size = div_round_up(size, texel_block_pixel_size);

    Ok([
        texel_block_size,
        texture_texel_block_size[0] * texel_block_size,
        texture_texel_block_size[0] * texture_texel_block_size[1] * texel_block_size,
    ])
}

fn sum_components(v: V3) -> i32 {
    v[0] + v[1] + v[2]
}

/// `copyImageData`
#[allow(clippy::too_many_arguments)]
fn copy_image_data(
    dst_image_data: &mut [Vec<u8>],
    dst_image_info: &ImageInfo,
    dst_level: i32,
    dst_pos: V3,
    src_image_data: &[Vec<u8>],
    src_image_info: &ImageInfo,
    src_level: i32,
    src_pos: V3,
    copy_size: V3,
) -> Result<(), TestError> {
    let src_level_data = &src_image_data[src_level as usize];
    let dst_level_data = &mut dst_image_data[dst_level as usize];

    let src_texel_block_pixel_size = get_texel_block_pixel_size(src_image_info.format)?;
    let src_texel_block_size = get_texel_block_size(src_image_info.format)?;
    let src_texel_pos = v3_div(src_pos, src_texel_block_pixel_size);
    let src_texel_block_stride = get_texel_block_stride(src_image_info, src_level)?;

    let dst_texel_block_pixel_size = get_texel_block_pixel_size(dst_image_info.format)?;
    let dst_texel_pos = v3_div(dst_pos, dst_texel_block_pixel_size);
    let dst_texel_block_stride = get_texel_block_stride(dst_image_info, dst_level)?;

    let copy_texel_block_count = v3_div(copy_size, src_texel_block_pixel_size);
    let texel_block_size = src_texel_block_size;

    let src_size = get_level_size(src_image_info.target, src_image_info.size, src_level);
    let dst_size = get_level_size(dst_image_info.target, dst_image_info.size, dst_level);
    if copy_size == src_size
        && copy_size == dst_size
        && src_level_data.len() == dst_level_data.len()
        && dst_pos == [0, 0, 0]
        && src_pos == [0, 0, 0]
    {
        // Entire layer copy case
        dst_level_data.copy_from_slice(src_level_data);
        return Ok(());
    }

    for z in 0..copy_texel_block_count[2] {
        for y in 0..copy_texel_block_count[1] {
            let block_pos = [0, y, z];
            let src_off = sum_components(v3_mul(v3_add(src_texel_pos, block_pos), src_texel_block_stride)) as usize;
            let dst_off = sum_components(v3_mul(v3_add(dst_texel_pos, block_pos), dst_texel_block_stride)) as usize;
            let copy_line_size = copy_texel_block_count[0] as usize * texel_block_size;

            dst_level_data[dst_off..dst_off + copy_line_size]
                .copy_from_slice(&src_level_data[src_off..src_off + copy_line_size]);
        }
    }
    Ok(())
}

/// `copyImage`
#[allow(clippy::too_many_arguments)]
fn copy_image(
    gl: &glw::Functions,
    dst_name: GLuint,
    dst_image_data: &mut [Vec<u8>],
    dst_image_info: &ImageInfo,
    dst_level: i32,
    dst_pos: V3,
    src_name: GLuint,
    src_image_data: &[Vec<u8>],
    src_image_info: &ImageInfo,
    src_level: i32,
    src_pos: V3,
    copy_size: V3,
) -> Result<(), TestError> {
    // SAFETY: both names are images this case created, and the sizes were derived from them.
    unsafe {
        gl.copy_image_sub_data(
            src_name,
            src_image_info.target,
            src_level,
            src_pos[0],
            src_pos[1],
            src_pos[2],
            dst_name,
            dst_image_info.target,
            dst_level,
            dst_pos[0],
            dst_pos[1],
            dst_pos[2],
            copy_size[0],
            copy_size[1],
            copy_size[2],
        );
    }
    glu::expect_no_error(gl, "glCopyImageSubData failed.")?;

    copy_image_data(
        dst_image_data,
        dst_image_info,
        dst_level,
        dst_pos,
        src_image_data,
        src_image_info,
        src_level,
        src_pos,
        copy_size,
    )
}

/// Draws one cell and, when asked, computes the host reference for it.
fn sample_reference(
    target: GLenum,
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: &[f32],
    params: &ReferenceParams,
) {
    match target {
        glw::GL_TEXTURE_2D => sample_texture_2d(
            dst,
            levels,
            tex_coord.try_into().expect("8 texture coordinates"),
            params,
        ),
        glw::GL_TEXTURE_3D => sample_texture_3d(
            dst,
            levels,
            tex_coord.try_into().expect("12 texture coordinates"),
            params,
        ),
        glw::GL_TEXTURE_CUBE_MAP => sample_texture_cube(
            dst,
            levels,
            tex_coord.try_into().expect("12 texture coordinates"),
            params,
        ),
        glw::GL_TEXTURE_2D_ARRAY => sample_texture_2d_array(
            dst,
            levels,
            tex_coord.try_into().expect("12 texture coordinates"),
            params,
        ),
        other => panic!("unsupported texture target {other:#x}"),
    }
}

/// `renderTexture<TextureView>`
#[allow(clippy::too_many_arguments)]
fn render_texture(
    context: &Context,
    renderer: &mut TextureRenderer<'_>,
    render_params: &mut ReferenceParams,
    results: &mut ResultCollector,
    rng: &mut Random,
    ref_levels: &[ConstPixelBufferAccess<'_>],
    verify: Verify,
    image_iterator: &mut TextureImageIterator,
) -> Result<(), TestError> {
    let render_target = context.render_target();
    let base_threshold = render_target.pixel_format().get_color_threshold();
    let threshold = UVec4::new(
        (base_threshold.get_red() + 1) as u32,
        (base_threshold.get_green() + 1) as u32,
        (base_threshold.get_blue() + 1) as u32,
        (base_threshold.get_alpha() + 1) as u32,
    );
    let gl = context.gl();
    let render_target_size = [render_target.width, render_target.height];
    let target = image_iterator.target;

    while image_iterator.has_next_image() {
        // Reserve space upfront using a conservative estimate for simplicity
        let images_on_level = image_iterator.level_image_count;
        let image_estimate = (image_iterator.level_count - image_iterator.current_level) * images_on_level;
        let mut render_grid = RandomizedRenderGrid::new(
            render_target_size,
            image_iterator.size(),
            image_estimate,
            rng.get_uint32(),
        );
        let mut cell_contents: Vec<CellContents> = Vec::new();

        // Ordering of conditions is significant: advancing one grid cell over the needed number has
        // no negative impact, the other way around would skip an image.
        while render_grid.next_cell() && image_iterator.next_image() {
            let level = image_iterator.current_level;
            let level_size = image_iterator.size();
            let origin = render_grid.get_origin();

            render_params.base_level = level;
            render_params.max_level = level;

            // SAFETY: the texture under test is bound to unit 0 by the caller.
            unsafe {
                gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, level);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, level);
            }

            let tex_coord =
                compute_quad_tex_coords(target, image_iterator.current_image, image_iterator.level_image_count);

            // SAFETY: plain state.
            unsafe { gl.viewport(origin[0], origin[1], level_size[0], level_size[1]) };

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            glu::expect_no_error(gl, "Failed to render.")?;

            if verify == Verify::CompareReference {
                let image_index = image_iterator.current_image;
                let mut reference = Surface::new(level_size[0], level_size[1]);

                sample_reference(
                    target,
                    &mut reference.get_access(),
                    ref_levels,
                    &tex_coord,
                    render_params,
                );

                cell_contents.push(CellContents {
                    origin,
                    reference,
                    name: get_texture_image_name(target, level, image_index),
                    description: get_texture_image_description(target, level, image_index),
                });
            }
        }

        if !cell_contents.is_empty() {
            let bounding_box = render_grid.get_used_area_bounding_box();
            let mut rendered_frame = Surface::new(bounding_box[2], bounding_box[3]);

            glu::read_pixels(
                &context.render_context,
                bounding_box[0],
                bounding_box[1],
                &mut rendered_frame.get_access(),
            )?;
            glu::expect_no_error(gl, "Failed to read pixels.")?;

            let frame_access = rendered_frame.get_const_access();
            for cell in &cell_contents {
                let cell_origin = [cell.origin[0] - bounding_box[0], cell.origin[1] - bounding_box[1]];
                let result_access = frame_access.get_subregion(
                    cell_origin[0] as u32,
                    cell_origin[1] as u32,
                    0,
                    cell.reference.get_width() as u32,
                    cell.reference.get_height() as u32,
                    1,
                );

                let result = int_threshold_compare(&cell.reference.get_const_access(), &result_access, threshold);
                if !result.ok {
                    results.fail(format!("Image comparison of {} failed.", cell.description));
                } else {
                    log::debug!("Image comparison of {} passed ({}).", cell.description, cell.name);
                }
            }
        }
    }

    // SAFETY: restoring the defaults on the texture under test.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 1000);
    }
    Ok(())
}

/// What `decompressTexture`/`decompressTextureLevel` produce for one level of one image.
fn decompress_level(
    compressed_format: vk::Format,
    level_pixel_size: V3,
    data: &[u8],
) -> Result<(Vec<u8>, TextureFormat), TestError> {
    let decompressed_format = crate::tcu::compressed_texture::get_uncompressed_format(compressed_format)
        .ok_or_else(|| TestError::InternalError("format cannot be decompressed".to_string()))?;
    let pixel_size = decompressed_format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("unsized decompressed format".to_string()))?
        as usize;
    let mut level_data =
        vec![0u8; (level_pixel_size[0] * level_pixel_size[1] * level_pixel_size[2]) as usize * pixel_size];

    {
        let mut access = PixelBufferAccess::new(
            decompressed_format,
            [
                level_pixel_size[0] as u32,
                level_pixel_size[1] as u32,
                level_pixel_size[2] as u32,
            ],
            &mut level_data,
        );
        if !crate::tcu::compressed_texture::decompress(&mut access, compressed_format, data) {
            return Err(TestError::InternalError("texture decompression failed".to_string()));
        }
    }
    Ok((level_data, decompressed_format))
}

/// Builds the reference level accesses (decompressing first when the format is compressed) and
/// hands them to `renderTexture`. Covers `renderTexture{2D,3D,Cubemap,2DArray}[View]`.
#[allow(clippy::too_many_arguments)]
fn render_texture_target(
    context: &Context,
    renderer: &mut TextureRenderer<'_>,
    results: &mut ResultCollector,
    rng: &mut Random,
    name: GLuint,
    data: &[Vec<u8>],
    info: &ImageInfo,
    verify: Verify,
) -> Result<(), TestError> {
    let gl = context.gl();
    let level_count = get_level_count(info);

    // Raw or decompressed level storage plus the format its accesses are read in.
    let mut decompressed: Vec<Vec<u8>> = Vec::new();

    let format: TextureFormat = if is_compressed_format(info.format) {
        let compressed_format = compressed_tex_format(info.format)?;
        let mut decompressed_format = None;

        for level in 0..level_count {
            let level_pixel_size = get_level_size(info.target, info.size, level);
            let level_pixel_size = if info.target == glw::GL_TEXTURE_CUBE_MAP {
                [level_pixel_size[0], level_pixel_size[1], 6]
            } else {
                level_pixel_size
            };
            let (level_data, level_format) =
                decompress_level(compressed_format, level_pixel_size, &data[level as usize])?;
            decompressed_format = Some(level_format);
            decompressed.push(level_data);
        }
        decompressed_format.ok_or_else(|| TestError::InternalError("texture without levels".to_string()))?
    } else {
        uncompressed_tex_format(info.format)?
    };
    let level_bytes: &[Vec<u8>] = if is_compressed_format(info.format) {
        &decompressed
    } else {
        data
    };

    let ref_levels: Vec<ConstPixelBufferAccess<'_>> = (0..level_count)
        .map(|level| {
            let size = get_level_size(info.target, info.size, level);
            let depth = if info.target == glw::GL_TEXTURE_CUBE_MAP {
                6
            } else {
                size[2]
            };
            ConstPixelBufferAccess::new(
                format,
                [size[0] as u32, size[1] as u32, depth as u32],
                &level_bytes[level as usize],
            )
        })
        .collect();

    let tex_type = match info.target {
        glw::GL_TEXTURE_2D => TextureType::Texture2D,
        glw::GL_TEXTURE_3D => TextureType::Texture3D,
        glw::GL_TEXTURE_CUBE_MAP => TextureType::Cube,
        glw::GL_TEXTURE_2D_ARRAY => TextureType::Texture2DArray,
        other => panic!("unsupported texture target {other:#x}"),
    };

    let spec = get_texture_format_info(format);
    let sampler = Sampler {
        normalized_coords: true,
        mip_filter: Some(MipmapFilterMode::Nearest),
        ..Sampler::clamp_to_edge(FilterMode::Nearest)
    };
    let mut render_params = ReferenceParams::new(tex_type, sampler, LodMode::Exact);
    render_params.base.sampler_type = get_sampler_type(format);
    render_params.base.color_scale = Vec4::from_array(spec.look_up_scale);
    render_params.base.color_bias = Vec4::from_array(spec.look_up_bias);

    // \note It seems we can't reliably sample two smallest texture levels with cubemaps
    let iterated_levels = if info.target == glw::GL_TEXTURE_CUBE_MAP {
        level_count - 2
    } else {
        level_count
    };
    let mut image_iterator = TextureImageIterator::new(info, iterated_levels);

    let target = info.target;
    // SAFETY: binds the texture under test and sets its sampling state.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(target, name);
    }
    glu::expect_no_error(gl, "Failed to bind texture.")?;

    // SAFETY: as above.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        if target == glw::GL_TEXTURE_3D {
            gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
        }
        gl.tex_parameteri(
            target,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }
    glu::expect_no_error(gl, "Failed to setup texture filtering state.")?;

    render_texture(
        context,
        renderer,
        &mut render_params,
        results,
        rng,
        &ref_levels,
        verify,
        &mut image_iterator,
    )?;

    // SAFETY: unbinding.
    unsafe { gl.bind_texture(target, 0) };
    glu::expect_no_error(gl, "Failed to unbind texture.")
}

/// `getReadPixelFormat`
fn get_read_pixel_format(format: TextureFormat) -> TextureFormat {
    match format.channel_class() {
        TextureChannelClass::FloatingPoint
        | TextureChannelClass::SignedFixedPoint
        | TextureChannelClass::UnsignedFixedPoint => TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        TextureChannelClass::SignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
        TextureChannelClass::UnsignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
        TextureChannelClass::Last => panic!("no read-back format for a combined depth/stencil format"),
    }
}

/// `calculateThreshold`
fn calculate_threshold(source_format: TextureFormat, read_pixels_format: TextureFormat) -> [f32; 4] {
    let src_bits = get_texture_format_bit_depth(source_format);
    let read_bits = get_texture_format_bit_depth(read_pixels_format);
    let min_bits: [i32; 4] = std::array::from_fn(|i| src_bits[i].min(read_bits[i]));

    std::array::from_fn(|i| {
        if min_bits[i] != 0 {
            1.0 / ((1i64 << min_bits[i]) - 1) as f32
        } else {
            0.0
        }
    })
}

/// `renderRenderbuffer`
fn render_renderbuffer(
    context: &Context,
    results: &mut ResultCollector,
    name: GLuint,
    data: &[Vec<u8>],
    info: &ImageInfo,
    verify: Verify,
) -> Result<(), TestError> {
    let gl = context.gl();

    let format = uncompressed_tex_format(info.format)?;
    let size = info.size;
    let ref_renderbuffer = ConstPixelBufferAccess::new(format, [size[0] as u32, size[1] as u32, 1], &data[0]);
    let read_pixels_format = get_read_pixel_format(format);
    let mut renderbuffer = TextureLevel::new(read_pixels_format, size[0] as u32, size[1] as u32, 1)?;

    {
        let framebuffer = Framebuffer::new(gl);

        // SAFETY: names this case generated or owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };
        glu::expect_no_error(gl, "Failed to create and bind framebuffer.")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, name);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                name,
            );
        }
        glu::expect_no_error(gl, "Failed to bind and attach renderbuffer to framebuffer.")?;

        if verify != Verify::None {
            glu::read_pixels(&context.render_context, 0, 0, &mut renderbuffer.get_access())?;
        }

        // SAFETY: unbinding.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        }
        glu::expect_no_error(gl, "Failed to unbind renderbuffer and framebuffer.")?;
    }

    if verify == Verify::CompareReference {
        let result_access = renderbuffer.get_const_access();

        if is_float_format(info.format) {
            if !float_ulp_threshold_compare(&ref_renderbuffer, &result_access, UVec4::new(2, 2, 2, 2)).ok {
                results.fail("Image comparison failed.");
            }
        } else if is_int_format(info.format) || is_uint_format(info.format) {
            if !int_threshold_compare(&ref_renderbuffer, &result_access, UVec4::new(1, 1, 1, 1)).ok {
                results.fail("Image comparison failed.");
            }
        } else {
            let threshold = calculate_threshold(format, read_pixels_format);
            if !float_threshold_compare(&ref_renderbuffer, &result_access, threshold).ok {
                results.fail("Image comparison failed.");
            }
        }
    }
    Ok(())
}

/// `render`
#[allow(clippy::too_many_arguments)]
fn render(
    context: &Context,
    renderer: &mut TextureRenderer<'_>,
    results: &mut ResultCollector,
    rng: &mut Random,
    name: GLuint,
    data: &[Vec<u8>],
    info: &ImageInfo,
    verify: Verify,
) -> Result<(), TestError> {
    match info.target {
        glw::GL_TEXTURE_2D | glw::GL_TEXTURE_3D | glw::GL_TEXTURE_CUBE_MAP | glw::GL_TEXTURE_2D_ARRAY => {
            render_texture_target(context, renderer, results, rng, name, data, info, verify)
        }
        glw::GL_RENDERBUFFER => render_renderbuffer(context, results, name, data, info, verify),
        other => panic!("unsupported target {other:#x}"),
    }
}

/// `Copy`
struct CopyRegion {
    src_pos: V3,
    src_level: i32,
    dst_pos: V3,
    dst_level: i32,
    size: V3,
}

/// `getLastFullLevel`
fn get_last_full_level(info: &ImageInfo) -> Result<i32, TestError> {
    let level_count = get_level_count(info);
    let block_pixel_size = get_texel_block_pixel_size(info.format)?;

    for level in 0..level_count {
        let level_size = get_level_size(info.target, info.size, level);

        if level_size[0] < block_pixel_size[0]
            || level_size[1] < block_pixel_size[1]
            || level_size[2] < block_pixel_size[2]
        {
            return Ok(level - 1);
        }
    }

    Ok(level_count - 1)
}

/// `generateCopies`
fn generate_copies(src_info: &ImageInfo, dst_info: &ImageInfo) -> Result<Vec<CopyRegion>, TestError> {
    let mut copies = Vec::new();

    let src_is_texture = is_texture_target(src_info.target);
    let dst_is_texture = is_texture_target(dst_info.target);

    let src_is_cube = src_info.target == glw::GL_TEXTURE_CUBE_MAP;
    let dst_is_cube = dst_info.target == glw::GL_TEXTURE_CUBE_MAP;

    let src_block_pixel_size = get_texel_block_pixel_size(src_info.format)?;
    let dst_block_pixel_size = get_texel_block_pixel_size(dst_info.format)?;

    const LEVELS: [i32; 3] = [0, 1, -1];

    for level_ndx in 0..(if src_is_texture || dst_is_texture {
        LEVELS.len()
    } else {
        1
    }) {
        let src_level = if src_is_texture {
            if LEVELS[level_ndx] >= 0 {
                LEVELS[level_ndx]
            } else {
                get_last_full_level(src_info)?
            }
        } else {
            0
        };
        let dst_level = if dst_is_texture {
            if LEVELS[level_ndx] >= 0 {
                LEVELS[level_ndx]
            } else {
                get_last_full_level(dst_info)?
            }
        } else {
            0
        };

        let src_size = get_level_size(src_info.target, src_info.size, src_level);
        let dst_size = get_level_size(dst_info.target, dst_info.size, dst_level);

        // \note These are rounded down
        let src_complete_block_size = [
            src_size[0] / src_block_pixel_size[0],
            src_size[1] / src_block_pixel_size[1],
            if src_is_cube {
                6
            } else {
                src_size[2] / src_block_pixel_size[2]
            },
        ];
        let dst_complete_block_size = [
            dst_size[0] / dst_block_pixel_size[0],
            dst_size[1] / dst_block_pixel_size[1],
            if dst_is_cube {
                6
            } else {
                dst_size[2] / dst_block_pixel_size[2]
            },
        ];

        let max_copy_block_size = v3_min(src_complete_block_size, dst_complete_block_size);

        // \note These are rounded down
        let copy_block_width = ((2 * (max_copy_block_size[0] / 4)) - 1).max(1);
        let copy_block_height = ((2 * (max_copy_block_size[1] / 4)) - 1).max(1);
        let copy_block_depth = ((2 * (max_copy_block_size[2] / 4)) - 1).max(1);
        let copy_block_size = [copy_block_width, copy_block_height, copy_block_depth];

        // Copy entire image level
        if !src_is_cube && !dst_is_cube && src_size == dst_size {
            copies.push(CopyRegion {
                src_pos: [0, 0, 0],
                src_level,
                dst_pos: [0, 0, 0],
                dst_level,
                size: src_size,
            });
        }

        // Copy NPOT block to (0,0,0) from other corner on src
        {
            let src_block_pos = v3_sub(src_complete_block_size, copy_block_size);
            let dst_block_pos = [0, 0, 0];

            copies.push(CopyRegion {
                src_pos: v3_mul(src_block_pos, src_block_pixel_size),
                src_level,
                dst_pos: v3_mul(dst_block_pos, dst_block_pixel_size),
                dst_level,
                size: v3_mul(copy_block_size, src_block_pixel_size),
            });
        }

        // Copy NPOT block from (0,0,0) to other corner on dst
        {
            let src_block_pos = [0, 0, 0];
            let dst_block_pos = v3_sub(dst_complete_block_size, copy_block_size);

            copies.push(CopyRegion {
                src_pos: v3_mul(src_block_pos, src_block_pixel_size),
                src_level,
                dst_pos: v3_mul(dst_block_pos, dst_block_pixel_size),
                dst_level,
                size: v3_mul(copy_block_size, src_block_pixel_size),
            });
        }

        // Copy NPOT block near the corner with high coordinates
        {
            let round4 = |v: V3| -> V3 { [(v[0] / 4) * 4, (v[1] / 4) * 4, (v[2] / 4) * 4] };
            let src_block_pos = v3_max(v3_sub(round4(src_complete_block_size), copy_block_size), [0, 0, 0]);
            let dst_block_pos = v3_max(v3_sub(round4(dst_complete_block_size), copy_block_size), [0, 0, 0]);

            copies.push(CopyRegion {
                src_pos: v3_mul(src_block_pos, src_block_pixel_size),
                src_level,
                dst_pos: v3_mul(dst_block_pos, dst_block_pixel_size),
                dst_level,
                size: v3_mul(copy_block_size, src_block_pixel_size),
            });
        }
    }

    Ok(copies)
}

/// `checkFormatSupport`
fn check_format_support(context: &Context, format: GLenum, target: GLenum) -> Result<(), TestError> {
    let is_es32 = context.context_type().supports(3, 2);
    let info = &context.context_info;

    if is_compressed_format(format) {
        if is_astc_format(compressed_tex_format(format)?) {
            debug_assert!(target != glw::GL_RENDERBUFFER);
            if !info.is_extension_supported("GL_KHR_texture_compression_astc_sliced_3d")
                && !info.is_extension_supported("GL_KHR_texture_compression_astc_hdr")
                && !info.is_extension_supported("GL_OES_texture_compression_astc")
            {
                if target == glw::GL_TEXTURE_3D {
                    return Err(TestError::NotSupported("TEXTURE_3D target not supported.".to_string()));
                }
                if !is_es32 && !info.is_extension_supported("GL_KHR_texture_compression_astc_ldr") {
                    return Err(TestError::NotSupported(
                        "Compressed astc texture not supported.".to_string(),
                    ));
                }
            }
        } else if !info.is_compressed_texture_format_supported(context.gl(), format) {
            return Err(TestError::NotSupported("Compressed texture not supported.".to_string()));
        }
    }
    Ok(())
}

/// `tcu::SeedBuilder`
struct SeedBuilder {
    hash: u32,
}

impl SeedBuilder {
    fn new() -> Self {
        Self { hash: 0xccf1_39d7 }
    }

    /// `advanceCrc32`
    fn feed_u32(&mut self, value: u32) {
        const GENERATOR: u32 = 0x04C1_1DB7;
        for byte in value.to_ne_bytes() {
            self.hash ^= u32::from(byte);
            for _ in 0..8 {
                self.hash = if self.hash & 1 != 0 {
                    (self.hash >> 1) ^ GENERATOR
                } else {
                    self.hash >> 1
                };
            }
        }
    }

    fn feed_image(&mut self, info: &ImageInfo) {
        self.feed_u32(info.format);
        self.feed_u32(info.target);
        for c in info.size {
            self.feed_u32(c as u32);
        }
    }
}

/// `CopyImageTest`
struct CopyImageTest {
    name: String,
    src_image_info: ImageInfo,
    dst_image_info: ImageInfo,
}

fn create_images<'gl>(
    gl: &'gl glw::Functions,
    rng: &mut Random,
    src_info: &ImageInfo,
    dst_info: &ImageInfo,
    src_levels: &mut Vec<Vec<u8>>,
    dst_levels: &mut Vec<Vec<u8>>,
) -> Result<(ImageObject<'gl>, ImageObject<'gl>), TestError> {
    let more_restrictive_format = get_more_restrictive_format(src_info.format, dst_info.format);

    let make = |info: &ImageInfo| {
        if is_texture_target(info.target) {
            ImageObject::Texture(Texture::new(gl))
        } else {
            ImageObject::Renderbuffer(Renderbuffer::new(gl))
        }
    };
    let src_image = make(src_info);
    let dst_image = make(dst_info);

    gen_image(gl, rng, src_image.get(), src_levels, src_info, more_restrictive_format)?;
    gen_image(gl, rng, dst_image.get(), dst_levels, dst_info, more_restrictive_format)?;
    Ok((src_image, dst_image))
}

impl TestCase for CopyImageTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let is_es32 = context.context_type().supports(3, 2);

        if !is_es32 && !context.context_info.is_extension_supported("GL_EXT_copy_image") {
            return Err(TestError::NotSupported(
                "Extension GL_EXT_copy_image not supported.".to_string(),
            ));
        }

        check_format_support(context, self.src_image_info.format, self.src_image_info.target)?;
        check_format_support(context, self.dst_image_info.format, self.dst_image_info.target)
    }

    /// `CopyImageTest::init` plus the six `iterate()` rounds, run back to back.
    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let gl = context.gl();
        let src_info = &self.src_image_info;
        let dst_info = &self.dst_image_info;

        let mut seed = SeedBuilder::new();
        seed.feed_u32(903980);
        seed.feed_image(src_info);
        seed.feed_image(dst_info);

        let mut rng = Random::new(seed.hash);
        let mut results = ResultCollector::new("");
        let mut renderer = TextureRenderer::new(
            &context.render_context,
            context.context_type().glsl_version(),
            Precision::HighP,
        );

        let mut src_levels: Vec<Vec<u8>> = Vec::new();
        let mut dst_levels: Vec<Vec<u8>> = Vec::new();

        let copies = generate_copies(src_info, dst_info)?;

        let (src_image, dst_image) = create_images(gl, &mut rng, src_info, dst_info, &mut src_levels, &mut dst_levels)?;
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            src_image.get(),
            &src_levels,
            src_info,
            Verify::None,
        )?;
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            dst_image.get(),
            &dst_levels,
            dst_info,
            Verify::None,
        )?;

        for copy in &copies {
            copy_image(
                gl,
                dst_image.get(),
                &mut dst_levels,
                dst_info,
                copy.dst_level,
                copy.dst_pos,
                src_image.get(),
                &src_levels,
                src_info,
                copy.src_level,
                copy.src_pos,
                copy.size,
            )?;
        }
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            src_image.get(),
            &src_levels,
            src_info,
            Verify::CompareReference,
        )?;
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            dst_image.get(),
            &dst_levels,
            dst_info,
            Verify::CompareReference,
        )?;
        drop(src_image);
        drop(dst_image);
        src_levels.clear();
        dst_levels.clear();

        let (src_image, dst_image) = create_images(gl, &mut rng, src_info, dst_info, &mut src_levels, &mut dst_levels)?;
        for copy in &copies {
            copy_image(
                gl,
                dst_image.get(),
                &mut dst_levels,
                dst_info,
                copy.dst_level,
                copy.dst_pos,
                src_image.get(),
                &src_levels,
                src_info,
                copy.src_level,
                copy.src_pos,
                copy.size,
            )?;
        }
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            src_image.get(),
            &src_levels,
            src_info,
            Verify::CompareReference,
        )?;
        render(
            context,
            &mut renderer,
            &mut results,
            &mut rng,
            dst_image.get(),
            &dst_levels,
            dst_info,
            Verify::CompareReference,
        )?;

        Ok(results.to_status())
    }
}

fn smallest_common_multiple(a_: i32, b_: i32) -> i32 {
    let mut a = a_.max(b_);
    let mut b = a_.min(b_);
    let mut result = 1;

    let mut i = b / 2;
    while i > 1 {
        while (a % i) == 0 && (b % i) == 0 {
            result *= i;
            a /= i;
            b /= i;
        }
        i -= 1;
    }

    result * a * b
}

/// `getTestedSize`
fn get_tested_size(target: GLenum, format: GLenum, target_size: V3) -> V3 {
    let texel_block_pixel_size = get_texel_block_pixel_size(format).expect("a known copy image format");
    let is_cube = target == glw::GL_TEXTURE_CUBE_MAP;
    let is_3d = target == glw::GL_TEXTURE_3D || target == glw::GL_TEXTURE_2D_ARRAY;

    if is_cube {
        let multiplier = smallest_common_multiple(texel_block_pixel_size[0], texel_block_pixel_size[1]);
        let size = (1 + (target_size[0] / multiplier)) * multiplier;

        [size, size, 1]
    } else if is_3d {
        v3_mul(
            [
                1 + target_size[0] / texel_block_pixel_size[0],
                1 + target_size[1] / texel_block_pixel_size[1],
                1 + target_size[2] / texel_block_pixel_size[2],
            ],
            texel_block_pixel_size,
        )
    } else {
        let width = (1 + target_size[0] / texel_block_pixel_size[0]) * texel_block_pixel_size[0];
        let height = ((target_size[1] / texel_block_pixel_size[1]) - 1) * texel_block_pixel_size[1];

        [width, height, 1]
    }
}

/// `addCopyTests`
fn add_copy_tests(root: &mut TestCaseGroup, src_format: GLenum, dst_format: GLenum) {
    let group_name = format!("{}_{}", format_to_name(src_format), format_to_name(dst_format));
    let mut group = TestCaseGroup::new(group_name);

    const TARGETS: [GLenum; 5] = [
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_3D,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_RENDERBUFFER,
    ];

    let is_astc = |format: GLenum| map_gl_compressed_tex_format(format).is_some_and(is_astc_format);

    for src_target in TARGETS {
        let src_is_3d = src_target == glw::GL_TEXTURE_2D_ARRAY || src_target == glw::GL_TEXTURE_3D;

        if is_compressed_format(src_format) && src_target == glw::GL_RENDERBUFFER {
            continue;
        }

        if src_target == glw::GL_RENDERBUFFER && !is_color_renderable(src_format) {
            continue;
        }

        if is_compressed_format(src_format) && !is_astc(src_format) && src_is_3d {
            continue;
        }

        for dst_target in TARGETS {
            let dst_is_3d = dst_target == glw::GL_TEXTURE_2D_ARRAY || dst_target == glw::GL_TEXTURE_3D;

            if is_compressed_format(dst_format) && dst_target == glw::GL_RENDERBUFFER {
                continue;
            }

            if dst_target == glw::GL_RENDERBUFFER && !is_color_renderable(dst_format) {
                continue;
            }

            if is_compressed_format(dst_format) && !is_astc(dst_format) && dst_is_3d {
                continue;
            }

            let target_test_name = format!("{}_to_{}", target_to_name(src_target), target_to_name(dst_target));

            // Compressed formats require more space to fit all block size combinations.
            let is_compressed_case = is_compressed_format(src_format) || is_compressed_format(dst_format);
            let target_size = if is_compressed_case {
                [128, 128, 16]
            } else {
                [64, 64, 8]
            };
            let src_size = get_tested_size(src_target, src_format, target_size);
            let dst_size = get_tested_size(dst_target, dst_format, target_size);

            group.add_child(Box::new(CopyImageTest {
                name: target_test_name,
                src_image_info: ImageInfo {
                    format: src_format,
                    target: src_target,
                    size: src_size,
                },
                dst_image_info: ImageInfo {
                    format: dst_format,
                    target: dst_target,
                    size: dst_size,
                },
            }) as Box<dyn TestCase>);
        }
    }

    root.add_child(group);
}

/// Every format pair of `formats` that is not float-to-different-float, as `CopyImageTests::init` loops them.
fn add_view_class_group(parent: &mut TestCaseGroup, view_class: ViewClass, formats: &[GLenum]) {
    let mut view_group = TestCaseGroup::new(view_class.0);

    for &src_format in formats {
        for &dst_format in formats {
            if src_format != dst_format && is_float_format(src_format) && is_float_format(dst_format) {
                continue;
            }

            add_copy_tests(&mut view_group, src_format, dst_format);
        }
    }

    parent.add_child(view_group);
}

/// `CopyImageTests::init` for ES (`m_isGL45 == false`).
pub fn create_tests() -> TestCaseGroup {
    // Texture view classes
    let texture_format_view_classes: [(ViewClass, Vec<GLenum>); 8] = [
        (
            VIEWCLASS_128_BITS,
            vec![glw::GL_RGBA32F, glw::GL_RGBA32I, glw::GL_RGBA32UI],
        ),
        (VIEWCLASS_96_BITS, vec![glw::GL_RGB32F, glw::GL_RGB32I, glw::GL_RGB32UI]),
        (
            VIEWCLASS_64_BITS,
            vec![
                glw::GL_RG32F,
                glw::GL_RG32I,
                glw::GL_RG32UI,
                glw::GL_RGBA16F,
                glw::GL_RGBA16I,
                glw::GL_RGBA16UI,
            ],
        ),
        (VIEWCLASS_48_BITS, vec![glw::GL_RGB16F, glw::GL_RGB16I, glw::GL_RGB16UI]),
        (
            VIEWCLASS_32_BITS,
            vec![
                glw::GL_R32F,
                glw::GL_R32I,
                glw::GL_R32UI,
                glw::GL_RG16F,
                glw::GL_RG16I,
                glw::GL_RG16UI,
                glw::GL_RGBA8,
                glw::GL_RGBA8I,
                glw::GL_RGBA8UI,
                glw::GL_R11F_G11F_B10F,
                glw::GL_RGB10_A2UI,
                glw::GL_RGB10_A2,
                glw::GL_RGBA8_SNORM,
                glw::GL_SRGB8_ALPHA8,
                glw::GL_RGB9_E5,
            ],
        ),
        (
            VIEWCLASS_24_BITS,
            vec![
                glw::GL_RGB8,
                glw::GL_RGB8I,
                glw::GL_RGB8UI,
                glw::GL_RGB8_SNORM,
                glw::GL_SRGB8,
            ],
        ),
        (
            VIEWCLASS_16_BITS,
            vec![
                glw::GL_R16F,
                glw::GL_R16I,
                glw::GL_R16UI,
                glw::GL_RG8,
                glw::GL_RG8I,
                glw::GL_RG8UI,
                glw::GL_RG8_SNORM,
            ],
        ),
        (
            VIEWCLASS_8_BITS,
            vec![glw::GL_R8, glw::GL_R8I, glw::GL_R8UI, glw::GL_R8_SNORM],
        ),
    ];

    // Compressed texture view classes
    let mut compressed_texture_format_view_classes: Vec<(ViewClass, Vec<GLenum>)> = vec![
        (
            ViewClass("viewclass_eac_r11"),
            vec![glw::GL_COMPRESSED_R11_EAC, glw::GL_COMPRESSED_SIGNED_R11_EAC],
        ),
        (
            ViewClass("viewclass_eac_rg11"),
            vec![glw::GL_COMPRESSED_RG11_EAC, glw::GL_COMPRESSED_SIGNED_RG11_EAC],
        ),
        (
            ViewClass("viewclass_etc2_rgb"),
            vec![glw::GL_COMPRESSED_RGB8_ETC2, glw::GL_COMPRESSED_SRGB8_ETC2],
        ),
        (
            ViewClass("viewclass_etc2_rgba"),
            vec![
                glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
                glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
            ],
        ),
        (
            ViewClass("viewclass_etc2_eac_rgba"),
            vec![
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
            ],
        ),
    ];
    // The ASTC view class names are `viewclass_astc_<w>x<h>_rgba`; leaked once so the
    // `ViewClass` newtype can stay a plain `&'static str`.
    for (rgba, srgb, size) in ASTC_FORMATS {
        let name: &'static str = Box::leak(format!("viewclass_astc_{size}_rgba").into_boxed_str());
        compressed_texture_format_view_classes.push((ViewClass(name), vec![rgba, srgb]));
    }

    // Mixed view classes: (view class, non compressed, compressed)
    let mut mixed_128_compressed = vec![
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
        glw::GL_COMPRESSED_RG11_EAC,
        glw::GL_COMPRESSED_SIGNED_RG11_EAC,
    ];
    for (rgba, _, _) in ASTC_FORMATS {
        mixed_128_compressed.push(rgba);
    }
    for (_, srgb, _) in ASTC_FORMATS {
        mixed_128_compressed.push(srgb);
    }
    let mixed_view_classes: [(ViewClass, Vec<GLenum>, Vec<GLenum>); 2] = [
        (
            VIEWCLASS_128_BITS,
            vec![glw::GL_RGBA32F, glw::GL_RGBA32UI, glw::GL_RGBA32I],
            mixed_128_compressed,
        ),
        (
            VIEWCLASS_64_BITS,
            vec![
                glw::GL_RGBA16F,
                glw::GL_RGBA16UI,
                glw::GL_RGBA16I,
                glw::GL_RG32F,
                glw::GL_RG32UI,
                glw::GL_RG32I,
            ],
            vec![glw::GL_COMPRESSED_R11_EAC, glw::GL_COMPRESSED_SIGNED_R11_EAC],
        ),
    ];

    let mut group = TestCaseGroup::new("copy_image");

    {
        let mut non_compressed_group = TestCaseGroup::new("non_compressed");
        for (view_class, formats) in &texture_format_view_classes {
            add_view_class_group(&mut non_compressed_group, *view_class, formats);
        }
        group.add_child(non_compressed_group);
    }

    {
        let mut compressed_group = TestCaseGroup::new("compressed");
        for (view_class, formats) in &compressed_texture_format_view_classes {
            add_view_class_group(&mut compressed_group, *view_class, formats);
        }
        group.add_child(compressed_group);
    }

    {
        let mut mixed_group = TestCaseGroup::new("mixed");
        for (view_class, non_compressed_formats, compressed_formats) in &mixed_view_classes {
            let view_class_name = format!("{}_mixed", view_class.0);
            let mut view_group = TestCaseGroup::new(view_class_name);

            for &src_format in non_compressed_formats {
                for &dst_format in compressed_formats {
                    if src_format != dst_format && is_float_format(src_format) && is_float_format(dst_format) {
                        continue;
                    }

                    add_copy_tests(&mut view_group, src_format, dst_format);
                    add_copy_tests(&mut view_group, dst_format, src_format);
                }
            }

            mixed_group.add_child(view_group);
        }
        group.add_child(mixed_group);
    }

    group
}
