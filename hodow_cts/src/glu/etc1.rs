// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuImageIO.cpp (loadPKM)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream reads `data/etc1/*.pkm` through the
// test-data archive; this binary has none, so the 57 files the ES 2.0/3.0 texture tests name
// (`hodow_cts/data/etc1/`, copied verbatim from upstream's `data/gles2/data/etc1`) are
// `include_bytes!`d and parsed on demand.
//
// ETC1 has no `vk::Format`: the images are decoded with the ETC2 RGB8 decoder (a strict superset
// for streams a valid ETC1 encoder produced) and uploaded under `GL_ETC1_RGB8_OES`, see
// `Texture2D::new_compressed_with_gl_format`.

use vulkanalia::vk;

use crate::glw::{self, GLenum};

/// The decoder `GL_ETC1_RGB8_OES` data goes through.
pub const ETC1_VK_FORMAT: vk::Format = vk::Format::ETC2_R8G8B8_UNORM_BLOCK;

/// The enum `glCompressedTexImage2D` is called with.
pub const ETC1_GL_FORMAT: GLenum = glw::GL_ETC1_RGB8_OES;

/// The extension a driver has to expose for the ETC1 cases to run.
pub const ETC1_EXTENSION: &str = "GL_OES_compressed_ETC1_RGB8_texture";

/// One parsed `.pkm`: the image's active size and its ETC1 blocks.
#[derive(Clone, Copy)]
pub struct Etc1Image {
    pub width: u32,
    pub height: u32,
    pub data: &'static [u8],
}

fn be16(bytes: &[u8], offset: usize) -> u32 {
    ((bytes[offset] as u32) << 8) | bytes[offset + 1] as u32
}

/// `tcu::ImageIO::loadPKM`: `"PKM 10"`, a type (0 = `ETC1_RGB_NO_MIPMAPS`), the padded size and the
/// active size, all big-endian 16-bit, then `ceil(w/4) * ceil(h/4)` eight-byte blocks.
fn parse_pkm(bytes: &'static [u8]) -> Etc1Image {
    assert!(
        bytes.len() >= 16 && &bytes[..6] == b"PKM 10",
        "Signature doesn't match PKM signature"
    );
    assert!(be16(bytes, 6) == 0, "Unsupported PKM type");

    let width = be16(bytes, 12);
    let height = be16(bytes, 14);
    let data_size = (width.div_ceil(4) * height.div_ceil(4) * 8) as usize;
    Etc1Image {
        width,
        height,
        data: &bytes[16..16 + data_size],
    }
}

macro_rules! pkm {
    ($name:literal) => {
        parse_pkm(include_bytes!(concat!("../../data/etc1/", $name, ".pkm")))
    };
}

/// `data/etc1/photo_helsinki_mip_<0..=7>.pkm`
pub fn photo_mip_levels() -> Vec<Etc1Image> {
    vec![
        pkm!("photo_helsinki_mip_0"),
        pkm!("photo_helsinki_mip_1"),
        pkm!("photo_helsinki_mip_2"),
        pkm!("photo_helsinki_mip_3"),
        pkm!("photo_helsinki_mip_4"),
        pkm!("photo_helsinki_mip_5"),
        pkm!("photo_helsinki_mip_6"),
        pkm!("photo_helsinki_mip_7"),
    ]
}

/// `data/etc1/photo_helsinki_113x89.pkm`
pub fn photo_npot() -> Etc1Image {
    pkm!("photo_helsinki_113x89")
}

/// `data/etc1/skybox_<face>_mip_<level>.pkm` for `level` 0..=6; `face` is a `tcu::CubeFace` index
/// (-X, +X, -Y, +Y, -Z, +Z).
pub fn skybox_pot(level: usize, face: usize) -> Etc1Image {
    match (level, face) {
        (0, 0) => pkm!("skybox_neg_x_mip_0"),
        (0, 1) => pkm!("skybox_pos_x_mip_0"),
        (0, 2) => pkm!("skybox_neg_y_mip_0"),
        (0, 3) => pkm!("skybox_pos_y_mip_0"),
        (0, 4) => pkm!("skybox_neg_z_mip_0"),
        (0, 5) => pkm!("skybox_pos_z_mip_0"),
        (1, 0) => pkm!("skybox_neg_x_mip_1"),
        (1, 1) => pkm!("skybox_pos_x_mip_1"),
        (1, 2) => pkm!("skybox_neg_y_mip_1"),
        (1, 3) => pkm!("skybox_pos_y_mip_1"),
        (1, 4) => pkm!("skybox_neg_z_mip_1"),
        (1, 5) => pkm!("skybox_pos_z_mip_1"),
        (2, 0) => pkm!("skybox_neg_x_mip_2"),
        (2, 1) => pkm!("skybox_pos_x_mip_2"),
        (2, 2) => pkm!("skybox_neg_y_mip_2"),
        (2, 3) => pkm!("skybox_pos_y_mip_2"),
        (2, 4) => pkm!("skybox_neg_z_mip_2"),
        (2, 5) => pkm!("skybox_pos_z_mip_2"),
        (3, 0) => pkm!("skybox_neg_x_mip_3"),
        (3, 1) => pkm!("skybox_pos_x_mip_3"),
        (3, 2) => pkm!("skybox_neg_y_mip_3"),
        (3, 3) => pkm!("skybox_pos_y_mip_3"),
        (3, 4) => pkm!("skybox_neg_z_mip_3"),
        (3, 5) => pkm!("skybox_pos_z_mip_3"),
        (4, 0) => pkm!("skybox_neg_x_mip_4"),
        (4, 1) => pkm!("skybox_pos_x_mip_4"),
        (4, 2) => pkm!("skybox_neg_y_mip_4"),
        (4, 3) => pkm!("skybox_pos_y_mip_4"),
        (4, 4) => pkm!("skybox_neg_z_mip_4"),
        (4, 5) => pkm!("skybox_pos_z_mip_4"),
        (5, 0) => pkm!("skybox_neg_x_mip_5"),
        (5, 1) => pkm!("skybox_pos_x_mip_5"),
        (5, 2) => pkm!("skybox_neg_y_mip_5"),
        (5, 3) => pkm!("skybox_pos_y_mip_5"),
        (5, 4) => pkm!("skybox_neg_z_mip_5"),
        (5, 5) => pkm!("skybox_pos_z_mip_5"),
        (6, 0) => pkm!("skybox_neg_x_mip_6"),
        (6, 1) => pkm!("skybox_pos_x_mip_6"),
        (6, 2) => pkm!("skybox_neg_y_mip_6"),
        (6, 3) => pkm!("skybox_pos_y_mip_6"),
        (6, 4) => pkm!("skybox_neg_z_mip_6"),
        (6, 5) => pkm!("skybox_pos_z_mip_6"),
        _ => panic!("no skybox ETC1 image for level {level}, face {face}"),
    }
}

/// `data/etc1/skybox_61x61_<face>.pkm`; `face` as in `skybox_pot`.
pub fn skybox_npot(face: usize) -> Etc1Image {
    match face {
        0 => pkm!("skybox_61x61_neg_x"),
        1 => pkm!("skybox_61x61_pos_x"),
        2 => pkm!("skybox_61x61_neg_y"),
        3 => pkm!("skybox_61x61_pos_y"),
        4 => pkm!("skybox_61x61_neg_z"),
        5 => pkm!("skybox_61x61_pos_z"),
        _ => panic!("no skybox ETC1 image for face {face}"),
    }
}

/// `levels[level][face]` of the seven-level pot skybox.
pub fn skybox_pot_levels() -> Vec<[Etc1Image; 6]> {
    (0..7)
        .map(|level| std::array::from_fn(|face| skybox_pot(level, face)))
        .collect()
}

/// The single-level 61x61 skybox, as `levels[0][face]`.
pub fn skybox_npot_levels() -> Vec<[Etc1Image; 6]> {
    vec![std::array::from_fn(skybox_npot)]
}
