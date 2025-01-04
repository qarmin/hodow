// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuAstcUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ASTC decoder and the random-valid-block generator that feeds it. A blit out of
// a compressed image needs both: the reference is what the source blocks decode to,
// and the source has to be made of blocks that are actually valid, because the
// comparison has no meaning for a block the decoder rejects.
//
// The 3D block sizes (VK_EXT_texture_compression_astc_3d) decode through the same functions with a block depth above 1
// (`getASTCBlockMode3D`, `interpolateWeights3D`); the random block generator is still 2D only.

// This file is a transcription: the bit-scattering, the index-keyed tables and the
// long argument lists all mirror tcuAstcUtil.cpp statement for statement, and the
// idiomatic forms clippy suggests would break that correspondence.
#![allow(
    clippy::needless_range_loop,
    clippy::too_many_arguments,
    clippy::manual_rotate,
    clippy::manual_range_contains
)]

use crate::tcu::pixel::PixelBufferAccess;
use crate::tcu::random::Random;

mod block_cases;
pub use block_cases::{
    BlockTestType, generate_block_case_test_data, generate_default_normal_blocks, generate_default_void_extent_blocks,
};

pub const BLOCK_SIZE_BYTES: usize = 16;

const MAX_BLOCK_WIDTH: usize = 12;
const MAX_BLOCK_HEIGHT: usize = 12;
const MAX_BLOCK_WIDTH_3D: usize = 6;
const MAX_BLOCK_HEIGHT_3D: usize = 6;
const MAX_BLOCK_DEPTH_3D: usize = 6;
/// The texels of the largest block of either kind (12x12 in 2D, 6x6x6 in 3D)
const MAX_BLOCK_TEXELS: usize =
    if MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT > MAX_BLOCK_WIDTH_3D * MAX_BLOCK_HEIGHT_3D * MAX_BLOCK_DEPTH_3D {
        MAX_BLOCK_WIDTH * MAX_BLOCK_HEIGHT
    } else {
        MAX_BLOCK_WIDTH_3D * MAX_BLOCK_HEIGHT_3D * MAX_BLOCK_DEPTH_3D
    };

fn get_bit(src: u32, ndx: u32) -> u32 {
    (src >> ndx) & 1
}

fn get_bits(src: u32, low: u32, high: u32) -> u32 {
    let num_bits = high - low + 1;
    if num_bits < 32 {
        (src >> low) & ((1u32 << num_bits) - 1)
    } else {
        src >> low
    }
}

fn is_bit_set(src: u32, ndx: u32) -> bool {
    get_bit(src, ndx) != 0
}

fn reverse_bits(src: u32, num_bits: u32) -> u32 {
    let mut result = 0;
    for i in 0..num_bits {
        result |= ((src >> i) & 1) << (num_bits - 1 - i);
    }
    result
}

/// `bitReplicationScale` - widen `src` by repeating it into the low bits.
fn bit_replication_scale(src: u32, num_src_bits: i32, num_dst_bits: i32) -> u32 {
    let mut dst = 0u32;
    let mut shift = num_dst_bits - num_src_bits;
    while shift > -num_src_bits {
        dst |= if shift >= 0 { src << shift } else { src >> -shift };
        shift -= num_src_bits;
    }
    dst
}

fn sign_extend(src: i32, num_src_bits: i32) -> i32 {
    let negative = (src & (1 << (num_src_bits - 1))) != 0;
    src | if negative { !((1 << num_src_bits) - 1) } else { 0 }
}

fn is_float16_inf_or_nan(v: u16) -> bool {
    get_bits(u32::from(v), 10, 14) == 31
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum IseMode {
    Trit,
    Quint,
    PlainBit,
    /// The "not set" state upstream spells `ISEMODE_LAST`.
    Last,
}

#[derive(Clone, Copy)]
struct IseParams {
    mode: IseMode,
    num_bits: i32,
}

impl IseParams {
    const fn new(mode: IseMode, num_bits: i32) -> Self {
        Self { mode, num_bits }
    }
}

fn div_round_up(a: i32, b: i32) -> i32 {
    (a + b - 1) / b
}

fn compute_num_required_bits(ise_params: &IseParams, num_values: i32) -> i32 {
    match ise_params.mode {
        IseMode::Trit => div_round_up(num_values * 8, 5) + num_values * ise_params.num_bits,
        IseMode::Quint => div_round_up(num_values * 7, 3) + num_values * ise_params.num_bits,
        IseMode::PlainBit => num_values * ise_params.num_bits,
        IseMode::Last => unreachable!("ISE mode not set"),
    }
}

/// `computeMaximumRangeISEParams`
fn compute_maximum_range_ise_params(num_available_bits: i32, num_values_in_sequence: i32) -> IseParams {
    let mut cur_bits_for_trit_mode = 6;
    let mut cur_bits_for_quint_mode = 5;
    let mut cur_bits_for_plain_bit_mode = 8;

    loop {
        let trit_range = if cur_bits_for_trit_mode > 0 {
            (3 << cur_bits_for_trit_mode) - 1
        } else {
            -1
        };
        let quint_range = if cur_bits_for_quint_mode > 0 {
            (5 << cur_bits_for_quint_mode) - 1
        } else {
            -1
        };
        let plain_bit_range = if cur_bits_for_plain_bit_mode > 0 {
            (1 << cur_bits_for_plain_bit_mode) - 1
        } else {
            -1
        };
        let max_range = trit_range.max(quint_range).max(plain_bit_range);

        if max_range == trit_range {
            let params = IseParams::new(IseMode::Trit, cur_bits_for_trit_mode);
            if compute_num_required_bits(&params, num_values_in_sequence) <= num_available_bits {
                return params;
            }
            cur_bits_for_trit_mode -= 1;
        } else if max_range == quint_range {
            let params = IseParams::new(IseMode::Quint, cur_bits_for_quint_mode);
            if compute_num_required_bits(&params, num_values_in_sequence) <= num_available_bits {
                return params;
            }
            cur_bits_for_quint_mode -= 1;
        } else {
            let params = IseParams::new(IseMode::PlainBit, cur_bits_for_plain_bit_mode);
            if compute_num_required_bits(&params, num_values_in_sequence) <= num_available_bits {
                return params;
            }
            cur_bits_for_plain_bit_mode -= 1;
        }
    }
}

fn compute_num_color_endpoint_values_for_mode(endpoint_mode: u32) -> i32 {
    ((endpoint_mode / 4 + 1) * 2) as i32
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DecompressResult {
    ValidBlock,
    Error,
}

/// `Block128` - a 128-bit block with little-endian bit addressing.
#[derive(Clone, Copy)]
struct Block128 {
    words: [u64; 2],
}

impl Block128 {
    fn new(src: &[u8]) -> Self {
        let mut words = [0u64; 2];
        for (word_ndx, word) in words.iter_mut().enumerate() {
            for byte_ndx in 0..8 {
                *word |= u64::from(src[word_ndx * 8 + byte_ndx]) << (8 * byte_ndx);
            }
        }
        Self { words }
    }

    fn get_bit(&self, ndx: u32) -> u32 {
        ((self.words[(ndx / 64) as usize] >> (ndx % 64)) & 1) as u32
    }

    fn get_bits(&self, low: u32, high: u32) -> u32 {
        if high < low {
            return 0;
        }
        let word0_ndx = (low / 64) as usize;
        let word1_ndx = (high / 64) as usize;

        // `x << bar << 1` rather than `x << (bar + 1)`, so the shift is never 64.
        if word0_ndx == word1_ndx {
            ((self.words[word0_ndx] & (((1u64 << (high % 64)) << 1).wrapping_sub(1))) >> (low % 64)) as u32
        } else {
            ((self.words[word0_ndx] >> (low % 64)) as u32)
                | ((self.words[word1_ndx] & (((1u64 << (high % 64)) << 1) - 1)) << (high - low - high % 64)) as u32
        }
    }

    fn is_bit_set(&self, ndx: u32) -> bool {
        self.get_bit(ndx) != 0
    }
}

/// `BitAccessStream` - sequential access into a `Block128`, forwards or backwards.
struct BitAccessStream<'a> {
    src: &'a Block128,
    start_ndx_in_src: i32,
    length: i32,
    forward: bool,
    ndx: i32,
}

impl<'a> BitAccessStream<'a> {
    fn new(src: &'a Block128, start_ndx_in_src: i32, length: i32, forward: bool) -> Self {
        Self {
            src,
            start_ndx_in_src,
            length,
            forward,
            ndx: 0,
        }
    }

    /// Get the next `num` bits. Bits at or past `m_length` read as zero.
    fn get_next(&mut self, num: i32) -> u32 {
        if num == 0 || self.ndx >= self.length {
            return 0;
        }
        let end = self.ndx + num;
        let num_bits_from_src = 0.max(self.length.min(end) - self.ndx);
        let low = self.ndx;
        let high = self.ndx + num_bits_from_src - 1;
        self.ndx += num;

        if self.forward {
            self.src.get_bits(
                (self.start_ndx_in_src + low) as u32,
                (self.start_ndx_in_src + high) as u32,
            )
        } else {
            reverse_bits(
                self.src.get_bits(
                    (self.start_ndx_in_src - high) as u32,
                    (self.start_ndx_in_src - low) as u32,
                ),
                num_bits_from_src as u32,
            )
        }
    }
}

#[derive(Clone, Copy, Default)]
struct IseDecodedResult {
    m: u32,
    /// Trit or quint value, depending on ISE mode.
    tq: u32,
    v: u32,
}

/// `ASTCBlockMode` - what an ASTC block's bits [0,10] say.
struct AstcBlockMode {
    is_error: bool,
    // The rest is only relevant if !is_error.
    is_void_extent: bool,
    // The rest is only relevant if !is_void_extent.
    is_dual_plane: bool,
    weight_grid_width: i32,
    weight_grid_height: i32,
    weight_grid_depth: i32,
    weight_ise_params: IseParams,
}

impl Default for AstcBlockMode {
    fn default() -> Self {
        Self {
            is_error: true,
            is_void_extent: true,
            is_dual_plane: true,
            weight_grid_width: -1,
            weight_grid_height: -1,
            weight_grid_depth: -1,
            weight_ise_params: IseParams::new(IseMode::Last, -1),
        }
    }
}

fn compute_num_weights(mode: &AstcBlockMode) -> i32 {
    mode.weight_grid_width * mode.weight_grid_height * mode.weight_grid_depth * if mode.is_dual_plane { 2 } else { 1 }
}

#[derive(Clone, Copy, Default)]
struct ColorEndpointPair {
    e0: [u32; 4],
    e1: [u32; 4],
}

#[derive(Clone, Copy, Default)]
struct TexelWeightPair {
    w: [u32; 2],
}

const TRITS_FROM_T: [[u8; 5]; 256] = [
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0],
    [2, 0, 0, 0, 0],
    [0, 0, 2, 0, 0],
    [0, 1, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [2, 1, 0, 0, 0],
    [1, 0, 2, 0, 0],
    [0, 2, 0, 0, 0],
    [1, 2, 0, 0, 0],
    [2, 2, 0, 0, 0],
    [2, 0, 2, 0, 0],
    [0, 2, 2, 0, 0],
    [1, 2, 2, 0, 0],
    [2, 2, 2, 0, 0],
    [2, 0, 2, 0, 0],
    [0, 0, 1, 0, 0],
    [1, 0, 1, 0, 0],
    [2, 0, 1, 0, 0],
    [0, 1, 2, 0, 0],
    [0, 1, 1, 0, 0],
    [1, 1, 1, 0, 0],
    [2, 1, 1, 0, 0],
    [1, 1, 2, 0, 0],
    [0, 2, 1, 0, 0],
    [1, 2, 1, 0, 0],
    [2, 2, 1, 0, 0],
    [2, 1, 2, 0, 0],
    [0, 0, 0, 2, 2],
    [1, 0, 0, 2, 2],
    [2, 0, 0, 2, 2],
    [0, 0, 2, 2, 2],
    [0, 0, 0, 1, 0],
    [1, 0, 0, 1, 0],
    [2, 0, 0, 1, 0],
    [0, 0, 2, 1, 0],
    [0, 1, 0, 1, 0],
    [1, 1, 0, 1, 0],
    [2, 1, 0, 1, 0],
    [1, 0, 2, 1, 0],
    [0, 2, 0, 1, 0],
    [1, 2, 0, 1, 0],
    [2, 2, 0, 1, 0],
    [2, 0, 2, 1, 0],
    [0, 2, 2, 1, 0],
    [1, 2, 2, 1, 0],
    [2, 2, 2, 1, 0],
    [2, 0, 2, 1, 0],
    [0, 0, 1, 1, 0],
    [1, 0, 1, 1, 0],
    [2, 0, 1, 1, 0],
    [0, 1, 2, 1, 0],
    [0, 1, 1, 1, 0],
    [1, 1, 1, 1, 0],
    [2, 1, 1, 1, 0],
    [1, 1, 2, 1, 0],
    [0, 2, 1, 1, 0],
    [1, 2, 1, 1, 0],
    [2, 2, 1, 1, 0],
    [2, 1, 2, 1, 0],
    [0, 1, 0, 2, 2],
    [1, 1, 0, 2, 2],
    [2, 1, 0, 2, 2],
    [1, 0, 2, 2, 2],
    [0, 0, 0, 2, 0],
    [1, 0, 0, 2, 0],
    [2, 0, 0, 2, 0],
    [0, 0, 2, 2, 0],
    [0, 1, 0, 2, 0],
    [1, 1, 0, 2, 0],
    [2, 1, 0, 2, 0],
    [1, 0, 2, 2, 0],
    [0, 2, 0, 2, 0],
    [1, 2, 0, 2, 0],
    [2, 2, 0, 2, 0],
    [2, 0, 2, 2, 0],
    [0, 2, 2, 2, 0],
    [1, 2, 2, 2, 0],
    [2, 2, 2, 2, 0],
    [2, 0, 2, 2, 0],
    [0, 0, 1, 2, 0],
    [1, 0, 1, 2, 0],
    [2, 0, 1, 2, 0],
    [0, 1, 2, 2, 0],
    [0, 1, 1, 2, 0],
    [1, 1, 1, 2, 0],
    [2, 1, 1, 2, 0],
    [1, 1, 2, 2, 0],
    [0, 2, 1, 2, 0],
    [1, 2, 1, 2, 0],
    [2, 2, 1, 2, 0],
    [2, 1, 2, 2, 0],
    [0, 2, 0, 2, 2],
    [1, 2, 0, 2, 2],
    [2, 2, 0, 2, 2],
    [2, 0, 2, 2, 2],
    [0, 0, 0, 0, 2],
    [1, 0, 0, 0, 2],
    [2, 0, 0, 0, 2],
    [0, 0, 2, 0, 2],
    [0, 1, 0, 0, 2],
    [1, 1, 0, 0, 2],
    [2, 1, 0, 0, 2],
    [1, 0, 2, 0, 2],
    [0, 2, 0, 0, 2],
    [1, 2, 0, 0, 2],
    [2, 2, 0, 0, 2],
    [2, 0, 2, 0, 2],
    [0, 2, 2, 0, 2],
    [1, 2, 2, 0, 2],
    [2, 2, 2, 0, 2],
    [2, 0, 2, 0, 2],
    [0, 0, 1, 0, 2],
    [1, 0, 1, 0, 2],
    [2, 0, 1, 0, 2],
    [0, 1, 2, 0, 2],
    [0, 1, 1, 0, 2],
    [1, 1, 1, 0, 2],
    [2, 1, 1, 0, 2],
    [1, 1, 2, 0, 2],
    [0, 2, 1, 0, 2],
    [1, 2, 1, 0, 2],
    [2, 2, 1, 0, 2],
    [2, 1, 2, 0, 2],
    [0, 2, 2, 2, 2],
    [1, 2, 2, 2, 2],
    [2, 2, 2, 2, 2],
    [2, 0, 2, 2, 2],
    [0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1],
    [2, 0, 0, 0, 1],
    [0, 0, 2, 0, 1],
    [0, 1, 0, 0, 1],
    [1, 1, 0, 0, 1],
    [2, 1, 0, 0, 1],
    [1, 0, 2, 0, 1],
    [0, 2, 0, 0, 1],
    [1, 2, 0, 0, 1],
    [2, 2, 0, 0, 1],
    [2, 0, 2, 0, 1],
    [0, 2, 2, 0, 1],
    [1, 2, 2, 0, 1],
    [2, 2, 2, 0, 1],
    [2, 0, 2, 0, 1],
    [0, 0, 1, 0, 1],
    [1, 0, 1, 0, 1],
    [2, 0, 1, 0, 1],
    [0, 1, 2, 0, 1],
    [0, 1, 1, 0, 1],
    [1, 1, 1, 0, 1],
    [2, 1, 1, 0, 1],
    [1, 1, 2, 0, 1],
    [0, 2, 1, 0, 1],
    [1, 2, 1, 0, 1],
    [2, 2, 1, 0, 1],
    [2, 1, 2, 0, 1],
    [0, 0, 1, 2, 2],
    [1, 0, 1, 2, 2],
    [2, 0, 1, 2, 2],
    [0, 1, 2, 2, 2],
    [0, 0, 0, 1, 1],
    [1, 0, 0, 1, 1],
    [2, 0, 0, 1, 1],
    [0, 0, 2, 1, 1],
    [0, 1, 0, 1, 1],
    [1, 1, 0, 1, 1],
    [2, 1, 0, 1, 1],
    [1, 0, 2, 1, 1],
    [0, 2, 0, 1, 1],
    [1, 2, 0, 1, 1],
    [2, 2, 0, 1, 1],
    [2, 0, 2, 1, 1],
    [0, 2, 2, 1, 1],
    [1, 2, 2, 1, 1],
    [2, 2, 2, 1, 1],
    [2, 0, 2, 1, 1],
    [0, 0, 1, 1, 1],
    [1, 0, 1, 1, 1],
    [2, 0, 1, 1, 1],
    [0, 1, 2, 1, 1],
    [0, 1, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [2, 1, 1, 1, 1],
    [1, 1, 2, 1, 1],
    [0, 2, 1, 1, 1],
    [1, 2, 1, 1, 1],
    [2, 2, 1, 1, 1],
    [2, 1, 2, 1, 1],
    [0, 1, 1, 2, 2],
    [1, 1, 1, 2, 2],
    [2, 1, 1, 2, 2],
    [1, 1, 2, 2, 2],
    [0, 0, 0, 2, 1],
    [1, 0, 0, 2, 1],
    [2, 0, 0, 2, 1],
    [0, 0, 2, 2, 1],
    [0, 1, 0, 2, 1],
    [1, 1, 0, 2, 1],
    [2, 1, 0, 2, 1],
    [1, 0, 2, 2, 1],
    [0, 2, 0, 2, 1],
    [1, 2, 0, 2, 1],
    [2, 2, 0, 2, 1],
    [2, 0, 2, 2, 1],
    [0, 2, 2, 2, 1],
    [1, 2, 2, 2, 1],
    [2, 2, 2, 2, 1],
    [2, 0, 2, 2, 1],
    [0, 0, 1, 2, 1],
    [1, 0, 1, 2, 1],
    [2, 0, 1, 2, 1],
    [0, 1, 2, 2, 1],
    [0, 1, 1, 2, 1],
    [1, 1, 1, 2, 1],
    [2, 1, 1, 2, 1],
    [1, 1, 2, 2, 1],
    [0, 2, 1, 2, 1],
    [1, 2, 1, 2, 1],
    [2, 2, 1, 2, 1],
    [2, 1, 2, 2, 1],
    [0, 2, 1, 2, 2],
    [1, 2, 1, 2, 2],
    [2, 2, 1, 2, 2],
    [2, 1, 2, 2, 2],
    [0, 0, 0, 1, 2],
    [1, 0, 0, 1, 2],
    [2, 0, 0, 1, 2],
    [0, 0, 2, 1, 2],
    [0, 1, 0, 1, 2],
    [1, 1, 0, 1, 2],
    [2, 1, 0, 1, 2],
    [1, 0, 2, 1, 2],
    [0, 2, 0, 1, 2],
    [1, 2, 0, 1, 2],
    [2, 2, 0, 1, 2],
    [2, 0, 2, 1, 2],
    [0, 2, 2, 1, 2],
    [1, 2, 2, 1, 2],
    [2, 2, 2, 1, 2],
    [2, 0, 2, 1, 2],
    [0, 0, 1, 1, 2],
    [1, 0, 1, 1, 2],
    [2, 0, 1, 1, 2],
    [0, 1, 2, 1, 2],
    [0, 1, 1, 1, 2],
    [1, 1, 1, 1, 2],
    [2, 1, 1, 1, 2],
    [1, 1, 2, 1, 2],
    [0, 2, 1, 1, 2],
    [1, 2, 1, 1, 2],
    [2, 2, 1, 1, 2],
    [2, 1, 2, 1, 2],
    [0, 2, 2, 2, 2],
    [1, 2, 2, 2, 2],
    [2, 2, 2, 2, 2],
    [2, 1, 2, 2, 2],
];

const QUINTS_FROM_Q: [[u8; 3]; 128] = [
    [0, 0, 0],
    [1, 0, 0],
    [2, 0, 0],
    [3, 0, 0],
    [4, 0, 0],
    [0, 4, 0],
    [4, 4, 0],
    [4, 4, 4],
    [0, 1, 0],
    [1, 1, 0],
    [2, 1, 0],
    [3, 1, 0],
    [4, 1, 0],
    [1, 4, 0],
    [4, 4, 1],
    [4, 4, 4],
    [0, 2, 0],
    [1, 2, 0],
    [2, 2, 0],
    [3, 2, 0],
    [4, 2, 0],
    [2, 4, 0],
    [4, 4, 2],
    [4, 4, 4],
    [0, 3, 0],
    [1, 3, 0],
    [2, 3, 0],
    [3, 3, 0],
    [4, 3, 0],
    [3, 4, 0],
    [4, 4, 3],
    [4, 4, 4],
    [0, 0, 1],
    [1, 0, 1],
    [2, 0, 1],
    [3, 0, 1],
    [4, 0, 1],
    [0, 4, 1],
    [4, 0, 4],
    [0, 4, 4],
    [0, 1, 1],
    [1, 1, 1],
    [2, 1, 1],
    [3, 1, 1],
    [4, 1, 1],
    [1, 4, 1],
    [4, 1, 4],
    [1, 4, 4],
    [0, 2, 1],
    [1, 2, 1],
    [2, 2, 1],
    [3, 2, 1],
    [4, 2, 1],
    [2, 4, 1],
    [4, 2, 4],
    [2, 4, 4],
    [0, 3, 1],
    [1, 3, 1],
    [2, 3, 1],
    [3, 3, 1],
    [4, 3, 1],
    [3, 4, 1],
    [4, 3, 4],
    [3, 4, 4],
    [0, 0, 2],
    [1, 0, 2],
    [2, 0, 2],
    [3, 0, 2],
    [4, 0, 2],
    [0, 4, 2],
    [2, 0, 4],
    [3, 0, 4],
    [0, 1, 2],
    [1, 1, 2],
    [2, 1, 2],
    [3, 1, 2],
    [4, 1, 2],
    [1, 4, 2],
    [2, 1, 4],
    [3, 1, 4],
    [0, 2, 2],
    [1, 2, 2],
    [2, 2, 2],
    [3, 2, 2],
    [4, 2, 2],
    [2, 4, 2],
    [2, 2, 4],
    [3, 2, 4],
    [0, 3, 2],
    [1, 3, 2],
    [2, 3, 2],
    [3, 3, 2],
    [4, 3, 2],
    [3, 4, 2],
    [2, 3, 4],
    [3, 3, 4],
    [0, 0, 3],
    [1, 0, 3],
    [2, 0, 3],
    [3, 0, 3],
    [4, 0, 3],
    [0, 4, 3],
    [0, 0, 4],
    [1, 0, 4],
    [0, 1, 3],
    [1, 1, 3],
    [2, 1, 3],
    [3, 1, 3],
    [4, 1, 3],
    [1, 4, 3],
    [0, 1, 4],
    [1, 1, 4],
    [0, 2, 3],
    [1, 2, 3],
    [2, 2, 3],
    [3, 2, 3],
    [4, 2, 3],
    [2, 4, 3],
    [0, 2, 4],
    [1, 2, 4],
    [0, 3, 3],
    [1, 3, 3],
    [2, 3, 3],
    [3, 3, 3],
    [4, 3, 3],
    [3, 4, 3],
    [0, 3, 4],
    [1, 3, 4],
];

/// `getASTCBlockMode`
fn get_astc_block_mode(block_mode_data: u32) -> AstcBlockMode {
    let mut block_mode = AstcBlockMode {
        weight_grid_depth: 1,
        ..Default::default()
    };

    block_mode.is_void_extent = get_bits(block_mode_data, 0, 8) == 0x1fc;

    if !block_mode.is_void_extent {
        if (get_bits(block_mode_data, 0, 1) == 0 && get_bits(block_mode_data, 6, 8) == 7)
            || get_bits(block_mode_data, 0, 3) == 0
        {
            return block_mode; // Invalid ("reserved").
        }

        let r;

        if get_bits(block_mode_data, 0, 1) == 0 {
            let r0 = get_bit(block_mode_data, 4);
            let r1 = get_bit(block_mode_data, 2);
            let r2 = get_bit(block_mode_data, 3);
            let i78 = get_bits(block_mode_data, 7, 8);

            r = (r2 << 2) | (r1 << 1) | r0;

            if i78 == 3 {
                let i5 = is_bit_set(block_mode_data, 5);
                block_mode.weight_grid_width = if i5 { 10 } else { 6 };
                block_mode.weight_grid_height = if i5 { 6 } else { 10 };
            } else {
                let a = get_bits(block_mode_data, 5, 6) as i32;
                match i78 {
                    0 => {
                        block_mode.weight_grid_width = 12;
                        block_mode.weight_grid_height = a + 2;
                    }
                    1 => {
                        block_mode.weight_grid_width = a + 2;
                        block_mode.weight_grid_height = 12;
                    }
                    _ => {
                        block_mode.weight_grid_width = a + 6;
                        block_mode.weight_grid_height = get_bits(block_mode_data, 9, 10) as i32 + 6;
                    }
                }
            }
        } else {
            let r0 = get_bit(block_mode_data, 4);
            let r1 = get_bit(block_mode_data, 0);
            let r2 = get_bit(block_mode_data, 1);
            let i23 = get_bits(block_mode_data, 2, 3);
            let a = get_bits(block_mode_data, 5, 6) as i32;

            r = (r2 << 2) | (r1 << 1) | r0;

            if i23 == 3 {
                let b = get_bit(block_mode_data, 7) as i32;
                let i8 = is_bit_set(block_mode_data, 8);
                block_mode.weight_grid_width = if i8 { b + 2 } else { a + 2 };
                block_mode.weight_grid_height = if i8 { a + 2 } else { b + 6 };
            } else {
                let b = get_bits(block_mode_data, 7, 8) as i32;
                match i23 {
                    0 => {
                        block_mode.weight_grid_width = b + 4;
                        block_mode.weight_grid_height = a + 2;
                    }
                    1 => {
                        block_mode.weight_grid_width = b + 8;
                        block_mode.weight_grid_height = a + 2;
                    }
                    _ => {
                        block_mode.weight_grid_width = a + 2;
                        block_mode.weight_grid_height = b + 8;
                    }
                }
            }
        }

        let zero_dh = get_bits(block_mode_data, 0, 1) == 0 && get_bits(block_mode_data, 7, 8) == 2;
        let h = !zero_dh && is_bit_set(block_mode_data, 9);
        block_mode.is_dual_plane = !zero_dh && is_bit_set(block_mode_data, 10);

        let (m, b) = if h {
            match r {
                2 => (IseMode::Quint, 1),
                3 => (IseMode::Trit, 2),
                4 => (IseMode::PlainBit, 4),
                5 => (IseMode::Quint, 2),
                6 => (IseMode::Trit, 3),
                _ => (IseMode::PlainBit, 5),
            }
        } else {
            match r {
                2 => (IseMode::PlainBit, 1),
                3 => (IseMode::Trit, 0),
                4 => (IseMode::PlainBit, 2),
                5 => (IseMode::Quint, 0),
                6 => (IseMode::Trit, 1),
                _ => (IseMode::PlainBit, 3),
            }
        };
        block_mode.weight_ise_params = IseParams::new(m, b);
    }

    block_mode.is_error = false;
    block_mode
}

/// `getASTCBlockMode3D`
fn get_astc_block_mode_3d(block_mode_data: u32) -> AstcBlockMode {
    let mut block_mode = AstcBlockMode::default();

    block_mode.is_void_extent = get_bits(block_mode_data, 0, 8) == 0x1fc;

    if !block_mode.is_void_extent {
        if (get_bits(block_mode_data, 0, 1) == 0 && get_bits(block_mode_data, 5, 8) == 7)
            || get_bits(block_mode_data, 0, 3) == 0
        {
            return block_mode; // Invalid ("reserved").
        }

        let r;

        if get_bits(block_mode_data, 0, 1) == 0 {
            let r0 = get_bit(block_mode_data, 4);
            let r1 = get_bit(block_mode_data, 2);
            let r2 = get_bit(block_mode_data, 3);
            let i78 = get_bits(block_mode_data, 7, 8);

            r = (r2 << 2) | (r1 << 1) | r0;

            if i78 == 3 {
                let i5 = is_bit_set(block_mode_data, 5);
                let i6 = is_bit_set(block_mode_data, 6);
                block_mode.weight_grid_width = if i5 || i6 { 2 } else { 6 };
                block_mode.weight_grid_height = if i5 { 6 } else { 2 };
                block_mode.weight_grid_depth = if i5 {
                    2
                } else if i6 {
                    6
                } else {
                    2
                };
            } else {
                let a = get_bits(block_mode_data, 9, 10) as i32;
                let b = get_bits(block_mode_data, 5, 6) as i32;
                match i78 {
                    0 => {
                        block_mode.weight_grid_width = 6;
                        block_mode.weight_grid_height = a + 2;
                        block_mode.weight_grid_depth = b + 2;
                    }
                    1 => {
                        block_mode.weight_grid_width = b + 2;
                        block_mode.weight_grid_height = 6;
                        block_mode.weight_grid_depth = a + 2;
                    }
                    _ => {
                        block_mode.weight_grid_width = b + 2;
                        block_mode.weight_grid_height = a + 2;
                        block_mode.weight_grid_depth = 6;
                    }
                }
            }
        } else {
            let r0 = get_bit(block_mode_data, 4);
            let r1 = get_bit(block_mode_data, 0);
            let r2 = get_bit(block_mode_data, 1);

            r = (r2 << 2) | (r1 << 1) | r0;

            block_mode.weight_grid_width = get_bits(block_mode_data, 5, 6) as i32 + 2;
            block_mode.weight_grid_height = get_bits(block_mode_data, 7, 8) as i32 + 2;
            block_mode.weight_grid_depth = get_bits(block_mode_data, 2, 3) as i32 + 2;
        }

        let zero_dh = get_bits(block_mode_data, 0, 1) == 0 && get_bits(block_mode_data, 7, 8) != 3;
        let h = !zero_dh && is_bit_set(block_mode_data, 9);
        block_mode.is_dual_plane = !zero_dh && is_bit_set(block_mode_data, 10);

        let (m, b) = if h {
            match r {
                2 => (IseMode::Quint, 1),
                3 => (IseMode::Trit, 2),
                4 => (IseMode::PlainBit, 4),
                5 => (IseMode::Quint, 2),
                6 => (IseMode::Trit, 3),
                _ => (IseMode::PlainBit, 5),
            }
        } else {
            match r {
                2 => (IseMode::PlainBit, 1),
                3 => (IseMode::Trit, 0),
                4 => (IseMode::PlainBit, 2),
                5 => (IseMode::Quint, 0),
                6 => (IseMode::Trit, 1),
                _ => (IseMode::PlainBit, 3),
            }
        };
        block_mode.weight_ise_params = IseParams::new(m, b);
    }

    block_mode.is_error = false;
    block_mode
}

/// `setASTCErrorColorBlock` - magenta, in whichever of the two destination layouts.
fn set_astc_error_color_block(
    dst: &mut [u8],
    block_width: usize,
    block_height: usize,
    block_depth: usize,
    is_srgb: bool,
) {
    for i in 0..block_width * block_height * block_depth {
        if is_srgb {
            dst[4 * i..4 * i + 4].copy_from_slice(&[0xff, 0, 0xff, 0xff]);
        } else {
            for (c, v) in [1.0f32, 0.0, 1.0, 1.0].into_iter().enumerate() {
                dst[(4 * i + c) * 4..(4 * i + c) * 4 + 4].copy_from_slice(&v.to_ne_bytes());
            }
        }
    }
}

fn write_f32(dst: &mut [u8], index: usize, value: f32) {
    dst[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

/// `decodeVoidExtentBlock`
fn decode_void_extent_block(
    dst: &mut [u8],
    block_data: &Block128,
    block_width: usize,
    block_height: usize,
    block_depth: usize,
    is_srgb: bool,
    is_ldr_mode: bool,
) -> DecompressResult {
    let min_s_extent = block_data.get_bits(12, 24);
    let max_s_extent = block_data.get_bits(25, 37);
    let min_t_extent = block_data.get_bits(38, 50);
    let max_t_extent = block_data.get_bits(51, 63);
    let all_extents_all_ones =
        min_s_extent == 0x1fff && max_s_extent == 0x1fff && min_t_extent == 0x1fff && max_t_extent == 0x1fff;
    let is_hdr_block = block_data.is_bit_set(9);

    if (is_ldr_mode && is_hdr_block)
        || (!all_extents_all_ones && (min_s_extent >= max_s_extent || min_t_extent >= max_t_extent))
    {
        set_astc_error_color_block(dst, block_width, block_height, block_depth, is_srgb);
        return DecompressResult::Error;
    }

    let rgba = [
        block_data.get_bits(64, 79),
        block_data.get_bits(80, 95),
        block_data.get_bits(96, 111),
        block_data.get_bits(112, 127),
    ];

    if is_srgb {
        for i in 0..block_width * block_height * block_depth {
            for c in 0..4 {
                dst[i * 4 + c] = ((rgba[c] & 0xff00) >> 8) as u8;
            }
        }
    } else if is_hdr_block {
        // Upstream throws here; a half that is Inf or NaN leaves the result undefined
        // by the ASTC spec, and no ported case is allowed to produce one.
        for c in 0..4 {
            if is_float16_inf_or_nan(rgba[c] as u16) {
                set_astc_error_color_block(dst, block_width, block_height, block_depth, is_srgb);
                return DecompressResult::Error;
            }
        }
        for i in 0..block_width * block_height * block_depth {
            for c in 0..4 {
                write_f32(dst, i * 4 + c, crate::tcu::pixel::f16_bits_to_f32(rgba[c] as u16));
            }
        }
    } else {
        for i in 0..block_width * block_height * block_depth {
            for c in 0..4 {
                write_f32(
                    dst,
                    i * 4 + c,
                    if rgba[c] == 65535 {
                        1.0
                    } else {
                        rgba[c] as f32 / 65536.0
                    },
                );
            }
        }
    }

    DecompressResult::ValidBlock
}

/// `decodeColorEndpointModes`
fn decode_color_endpoint_modes(
    endpoint_modes_dst: &mut [u32; 4],
    block_data: &Block128,
    num_partitions: i32,
    extra_cem_bits_start: u32,
) {
    if num_partitions == 1 {
        endpoint_modes_dst[0] = block_data.get_bits(13, 16);
    } else {
        let high_level_selector = block_data.get_bits(23, 24);

        if high_level_selector == 0 {
            let mode = block_data.get_bits(25, 28);
            for e in endpoint_modes_dst.iter_mut().take(num_partitions as usize) {
                *e = mode;
            }
        } else {
            for part_ndx in 0..num_partitions as u32 {
                let cem_class = high_level_selector - u32::from(!block_data.is_bit_set(25 + part_ndx));
                let low_bit0_ndx = num_partitions as u32 + 2 * part_ndx;
                let low_bit1_ndx = num_partitions as u32 + 2 * part_ndx + 1;
                let low_bit0 = block_data.get_bit(if low_bit0_ndx < 4 {
                    25 + low_bit0_ndx
                } else {
                    extra_cem_bits_start + low_bit0_ndx - 4
                });
                let low_bit1 = block_data.get_bit(if low_bit1_ndx < 4 {
                    25 + low_bit1_ndx
                } else {
                    extra_cem_bits_start + low_bit1_ndx - 4
                });

                endpoint_modes_dst[part_ndx as usize] = (cem_class << 2) | (low_bit1 << 1) | low_bit0;
            }
        }
    }
}

fn compute_num_color_endpoint_values(endpoint_modes: &[u32; 4], num_partitions: i32) -> i32 {
    (0..num_partitions as usize)
        .map(|i| compute_num_color_endpoint_values_for_mode(endpoint_modes[i]))
        .sum()
}

/// `decodeISETritBlock`
fn decode_ise_trit_block(dst: &mut [IseDecodedResult], num_values: i32, data: &mut BitAccessStream<'_>, num_bits: i32) {
    let mut m = [0u32; 5];
    m[0] = data.get_next(num_bits);
    let t01 = data.get_next(2);
    m[1] = data.get_next(num_bits);
    let mut t23 = data.get_next(2);
    m[2] = data.get_next(num_bits);
    let mut t4 = data.get_next(1);
    m[3] = data.get_next(num_bits);
    let mut t56 = data.get_next(2);
    m[4] = data.get_next(num_bits);
    let mut t7 = data.get_next(1);

    // The fallthrough chain upstream zeroes every field past `num_values`.
    if num_values <= 1 {
        t23 = 0;
    }
    if num_values <= 2 {
        t4 = 0;
    }
    if num_values <= 3 {
        t56 = 0;
    }
    if num_values <= 4 {
        t7 = 0;
    }

    let t = (t7 << 7) | (t56 << 5) | (t4 << 4) | (t23 << 2) | t01;
    let trits = &TRITS_FROM_T[t as usize];

    for i in 0..num_values as usize {
        dst[i].m = m[i];
        dst[i].tq = u32::from(trits[i]);
        dst[i].v = (u32::from(trits[i]) << num_bits) + m[i];
    }
}

/// `decodeISEQuintBlock`
fn decode_ise_quint_block(
    dst: &mut [IseDecodedResult],
    num_values: i32,
    data: &mut BitAccessStream<'_>,
    num_bits: i32,
) {
    let mut m = [0u32; 3];
    m[0] = data.get_next(num_bits);
    let q012 = data.get_next(3);
    m[1] = data.get_next(num_bits);
    let mut q34 = data.get_next(2);
    m[2] = data.get_next(num_bits);
    let mut q56 = data.get_next(2);

    if num_values <= 1 {
        q34 = 0;
    }
    if num_values <= 2 {
        q56 = 0;
    }

    let q = (q56 << 5) | (q34 << 3) | q012;
    let quints = &QUINTS_FROM_Q[q as usize];

    for i in 0..num_values as usize {
        dst[i].m = m[i];
        dst[i].tq = u32::from(quints[i]);
        dst[i].v = (u32::from(quints[i]) << num_bits) + m[i];
    }
}

/// `decodeISE`
fn decode_ise(dst: &mut [IseDecodedResult], num_values: i32, data: &mut BitAccessStream<'_>, params: &IseParams) {
    match params.mode {
        IseMode::Trit => {
            let num_blocks = div_round_up(num_values, 5);
            for block_ndx in 0..num_blocks {
                let num_values_in_block = if block_ndx == num_blocks - 1 {
                    num_values - 5 * (num_blocks - 1)
                } else {
                    5
                };
                decode_ise_trit_block(
                    &mut dst[5 * block_ndx as usize..],
                    num_values_in_block,
                    data,
                    params.num_bits,
                );
            }
        }
        IseMode::Quint => {
            let num_blocks = div_round_up(num_values, 3);
            for block_ndx in 0..num_blocks {
                let num_values_in_block = if block_ndx == num_blocks - 1 {
                    num_values - 3 * (num_blocks - 1)
                } else {
                    3
                };
                decode_ise_quint_block(
                    &mut dst[3 * block_ndx as usize..],
                    num_values_in_block,
                    data,
                    params.num_bits,
                );
            }
        }
        _ => {
            for d in dst.iter_mut().take(num_values as usize) {
                d.m = data.get_next(params.num_bits);
                d.v = d.m;
            }
        }
    }
}

/// `unquantizeColorEndpoints`
fn unquantize_color_endpoints(
    dst: &mut [u32],
    ise_results: &[IseDecodedResult],
    num_endpoints: i32,
    ise_params: &IseParams,
) {
    if ise_params.mode == IseMode::Trit || ise_params.mode == IseMode::Quint {
        let range_case = ise_params.num_bits * 2 - if ise_params.mode == IseMode::Trit { 2 } else { 1 };
        const CA: [u32; 11] = [204, 113, 93, 54, 44, 26, 22, 13, 11, 6, 5];
        let c = CA[range_case as usize];

        for endpoint_ndx in 0..num_endpoints as usize {
            let m = ise_results[endpoint_ndx].m;
            let (a, b, c_, d, e, f) = (
                get_bit(m, 0),
                get_bit(m, 1),
                get_bit(m, 2),
                get_bit(m, 3),
                get_bit(m, 4),
                get_bit(m, 5),
            );

            let big_a = if a == 0 { 0 } else { (1 << 9) - 1 };
            let big_b = match range_case {
                0 | 1 => 0,
                2 => (b << 8) | (b << 4) | (b << 2) | (b << 1),
                3 => (b << 8) | (b << 3) | (b << 2),
                4 => (c_ << 8) | (b << 7) | (c_ << 3) | (b << 2) | (c_ << 1) | b,
                5 => (c_ << 8) | (b << 7) | (c_ << 2) | (b << 1) | c_,
                6 => (d << 8) | (c_ << 7) | (b << 6) | (d << 2) | (c_ << 1) | b,
                7 => (d << 8) | (c_ << 7) | (b << 6) | (d << 1) | c_,
                8 => (e << 8) | (d << 7) | (c_ << 6) | (b << 5) | (e << 1) | d,
                9 => (e << 8) | (d << 7) | (c_ << 6) | (b << 5) | e,
                _ => (f << 8) | (e << 7) | (d << 6) | (c_ << 5) | (b << 4) | f,
            };

            dst[endpoint_ndx] = (((ise_results[endpoint_ndx].tq * c + big_b) ^ big_a) >> 2) | (big_a & 0x80);
        }
    } else {
        for endpoint_ndx in 0..num_endpoints as usize {
            dst[endpoint_ndx] = bit_replication_scale(ise_results[endpoint_ndx].v, ise_params.num_bits, 8);
        }
    }
}

/// `bitTransferSigned`
fn bit_transfer_signed(a: &mut i32, b: &mut i32) {
    *b >>= 1;
    *b |= *a & 0x80;
    *a >>= 1;
    *a &= 0x3f;
    if is_bit_set(*a as u32, 5) {
        *a -= 0x40;
    }
}

/// `clampedRGBA`
fn clamped_rgba(rgba: [i32; 4]) -> [u32; 4] {
    std::array::from_fn(|i| rgba[i].clamp(0, 0xff) as u32)
}

/// `blueContract`
fn blue_contract(r: i32, g: i32, b: i32, a: i32) -> [i32; 4] {
    [(r + b) >> 1, (g + b) >> 1, b, a]
}

fn is_color_endpoint_mode_hdr(mode: u32) -> bool {
    matches!(mode, 2 | 3 | 7 | 11 | 14 | 15)
}

/// `decodeHDREndpointMode7`
fn decode_hdr_endpoint_mode7(e0: &mut [u32; 4], e1: &mut [u32; 4], v0: u32, v1: u32, v2: u32, v3: u32) {
    let m10 = get_bit(v1, 7) | (get_bit(v2, 7) << 1);
    let m23 = get_bits(v0, 6, 7);
    let maj_comp = if m10 != 3 {
        m10
    } else if m23 != 3 {
        m23
    } else {
        0
    };
    let mode = if m10 != 3 {
        m23
    } else if m23 != 3 {
        4
    } else {
        5
    };

    // R, G, B, S in upstream's ASSIGN_X_BITS macro, indexed so the table below reads
    // the same way the macro invocations do.
    const R: usize = 0;
    const G: usize = 1;
    const B: usize = 2;
    const S: usize = 3;
    let mut rgbs: [i32; 4] = [
        get_bits(v0, 0, 5) as i32,
        get_bits(v1, 0, 4) as i32,
        get_bits(v2, 0, 4) as i32,
        get_bits(v3, 0, 4) as i32,
    ];

    let x = [
        get_bit(v1, 6),
        get_bit(v1, 5),
        get_bit(v2, 6),
        get_bit(v2, 5),
        get_bit(v3, 7),
        get_bit(v3, 6),
        get_bit(v3, 5),
    ];

    // (destination, shift) for x0..x6, one row per mode.
    const ASSIGNMENTS: [[(usize, u32); 7]; 6] = [
        [(R, 9), (R, 8), (R, 7), (R, 10), (R, 6), (S, 6), (S, 5)],
        [(R, 8), (G, 5), (R, 7), (B, 5), (R, 6), (R, 10), (R, 9)],
        [(R, 9), (R, 8), (R, 7), (R, 6), (S, 7), (S, 6), (S, 5)],
        [(R, 8), (G, 5), (R, 7), (B, 5), (R, 6), (S, 6), (S, 5)],
        [(G, 6), (G, 5), (B, 6), (B, 5), (R, 6), (R, 7), (S, 5)],
        [(G, 6), (G, 5), (B, 6), (B, 5), (R, 6), (S, 6), (S, 5)],
    ];
    for (i, &(dst, shift)) in ASSIGNMENTS[mode as usize].iter().enumerate() {
        rgbs[dst] |= (x[i] << shift) as i32;
    }

    const SHIFT_AMOUNTS: [i32; 6] = [1, 1, 2, 3, 4, 5];
    for v in &mut rgbs {
        *v <<= SHIFT_AMOUNTS[mode as usize];
    }

    if mode != 5 {
        rgbs[G] = rgbs[R] - rgbs[G];
        rgbs[B] = rgbs[R] - rgbs[B];
    }

    if maj_comp == 1 {
        rgbs.swap(R, G);
    } else if maj_comp == 2 {
        rgbs.swap(R, B);
    }

    let scale = rgbs[S];
    *e0 = [
        (rgbs[R] - scale).clamp(0, 0xfff) as u32,
        (rgbs[G] - scale).clamp(0, 0xfff) as u32,
        (rgbs[B] - scale).clamp(0, 0xfff) as u32,
        0x780,
    ];
    *e1 = [
        rgbs[R].clamp(0, 0xfff) as u32,
        rgbs[G].clamp(0, 0xfff) as u32,
        rgbs[B].clamp(0, 0xfff) as u32,
        0x780,
    ];
}

/// `decodeHDREndpointMode11`
fn decode_hdr_endpoint_mode11(
    e0: &mut [u32; 4],
    e1: &mut [u32; 4],
    v0: u32,
    v1: u32,
    v2: u32,
    v3: u32,
    v4: u32,
    v5: u32,
) {
    let major = (get_bit(v5, 7) << 1) | get_bit(v4, 7);

    if major == 3 {
        *e0 = [v0 << 4, v2 << 4, get_bits(v4, 0, 6) << 5, 0x780];
        *e1 = [v1 << 4, v3 << 4, get_bits(v5, 0, 6) << 5, 0x780];
        return;
    }

    let mode = (get_bit(v3, 7) << 2) | (get_bit(v2, 7) << 1) | get_bit(v1, 7);

    // a, c, b0, b1, d0, d1 - indexed so the assignment table reads like the macro.
    const A: usize = 0;
    const C: usize = 1;
    const B0: usize = 2;
    const B1: usize = 3;
    const D0: usize = 4;
    const D1: usize = 5;
    let mut vals: [i32; 6] = [
        ((get_bit(v1, 6) << 8) | v0) as i32,
        get_bits(v1, 0, 5) as i32,
        get_bits(v2, 0, 5) as i32,
        get_bits(v3, 0, 5) as i32,
        get_bits(v4, 0, 4) as i32,
        get_bits(v5, 0, 4) as i32,
    ];

    let x = [
        get_bit(v2, 6),
        get_bit(v3, 6),
        get_bit(v4, 6),
        get_bit(v5, 6),
        get_bit(v4, 5),
        get_bit(v5, 5),
    ];

    const ASSIGNMENTS: [[(usize, u32); 6]; 8] = [
        [(B0, 6), (B1, 6), (D0, 6), (D1, 6), (D0, 5), (D1, 5)],
        [(B0, 6), (B1, 6), (B0, 7), (B1, 7), (D0, 5), (D1, 5)],
        [(A, 9), (C, 6), (D0, 6), (D1, 6), (D0, 5), (D1, 5)],
        [(B0, 6), (B1, 6), (A, 9), (C, 6), (D0, 5), (D1, 5)],
        [(B0, 6), (B1, 6), (B0, 7), (B1, 7), (A, 9), (A, 10)],
        [(A, 9), (A, 10), (C, 7), (C, 6), (D0, 5), (D1, 5)],
        [(B0, 6), (B1, 6), (A, 11), (C, 6), (A, 9), (A, 10)],
        [(A, 9), (A, 10), (A, 11), (C, 6), (D0, 5), (D1, 5)],
    ];
    for (i, &(dst, shift)) in ASSIGNMENTS[mode as usize].iter().enumerate() {
        vals[dst] |= (x[i] << shift) as i32;
    }

    const NUM_D_BITS: [i32; 8] = [7, 6, 7, 6, 5, 6, 5, 6];
    vals[D0] = sign_extend(vals[D0], NUM_D_BITS[mode as usize]);
    vals[D1] = sign_extend(vals[D1], NUM_D_BITS[mode as usize]);

    let shift_amount = (mode >> 1) ^ 3;
    for v in &mut vals {
        *v <<= shift_amount;
    }
    let (a, c, b0, b1, d0, d1) = (vals[A], vals[C], vals[B0], vals[B1], vals[D0], vals[D1]);

    *e0 = [
        (a - c).clamp(0, 0xfff) as u32,
        (a - b0 - c - d0).clamp(0, 0xfff) as u32,
        (a - b1 - c - d1).clamp(0, 0xfff) as u32,
        0x780,
    ];
    *e1 = [
        a.clamp(0, 0xfff) as u32,
        (a - b0).clamp(0, 0xfff) as u32,
        (a - b1).clamp(0, 0xfff) as u32,
        0x780,
    ];

    if major == 1 {
        e0.swap(0, 1);
        e1.swap(0, 1);
    } else if major == 2 {
        e0.swap(0, 2);
        e1.swap(0, 2);
    }
}

/// `decodeHDREndpointMode15`
#[allow(clippy::too_many_arguments)]
fn decode_hdr_endpoint_mode15(
    e0: &mut [u32; 4],
    e1: &mut [u32; 4],
    v0: u32,
    v1: u32,
    v2: u32,
    v3: u32,
    v4: u32,
    v5: u32,
    v6_in: u32,
    v7_in: u32,
) {
    decode_hdr_endpoint_mode11(e0, e1, v0, v1, v2, v3, v4, v5);

    let mode = (get_bit(v7_in, 7) << 1) | get_bit(v6_in, 7);
    let mut v6 = get_bits(v6_in, 0, 6) as i32;
    let mut v7 = get_bits(v7_in, 0, 6) as i32;

    if mode == 3 {
        e0[3] = (v6 << 5) as u32;
        e1[3] = (v7 << 5) as u32;
    } else {
        v6 |= (v7 << (mode + 1)) & 0x780;
        v7 &= 0x3f >> mode;
        v7 ^= 0x20 >> mode;
        v7 -= 0x20 >> mode;
        v6 <<= 4 - mode;
        v7 <<= 4 - mode;

        v7 += v6;
        v7 = v7.clamp(0, 0xfff);
        e0[3] = v6 as u32;
        e1[3] = v7 as u32;
    }
}

/// `decodeColorEndpoints`
fn decode_color_endpoints(
    dst: &mut [ColorEndpointPair; 4],
    unquantized_endpoints: &[u32],
    endpoint_modes: &[u32; 4],
    num_partitions: i32,
) {
    let mut unquantized_ndx = 0usize;

    for partition_ndx in 0..num_partitions as usize {
        let endpoint_mode = endpoint_modes[partition_ndx];
        let v = &unquantized_endpoints[unquantized_ndx..];
        let mut e0 = [0u32; 4];
        let mut e1 = [0u32; 4];

        unquantized_ndx += compute_num_color_endpoint_values_for_mode(endpoint_mode) as usize;

        match endpoint_mode {
            0 => {
                e0 = [v[0], v[0], v[0], 0xff];
                e1 = [v[1], v[1], v[1], 0xff];
            }
            1 => {
                let l0 = (v[0] >> 2) | (get_bits(v[1], 6, 7) << 6);
                let l1 = 0xffu32.min(l0 + get_bits(v[1], 0, 5));
                e0 = [l0, l0, l0, 0xff];
                e1 = [l1, l1, l1, 0xff];
            }
            2 => {
                let v1_gr = v[1] >= v[0];
                let y0 = if v1_gr { v[0] << 4 } else { (v[1] << 4) + 8 };
                let y1 = if v1_gr { v[1] << 4 } else { (v[0] << 4) - 8 };
                e0 = [y0, y0, y0, 0x780];
                e1 = [y1, y1, y1, 0x780];
            }
            3 => {
                let m = is_bit_set(v[0], 7);
                let y0 = if m {
                    (get_bits(v[1], 5, 7) << 9) | (get_bits(v[0], 0, 6) << 2)
                } else {
                    (get_bits(v[1], 4, 7) << 8) | (get_bits(v[0], 0, 6) << 1)
                };
                let d = if m {
                    get_bits(v[1], 0, 4) << 2
                } else {
                    get_bits(v[1], 0, 3) << 1
                };
                let y1 = 0xfffu32.min(y0 + d);
                e0 = [y0, y0, y0, 0x780];
                e1 = [y1, y1, y1, 0x780];
            }
            4 => {
                e0 = [v[0], v[0], v[0], v[2]];
                e1 = [v[1], v[1], v[1], v[3]];
            }
            5 => {
                let (mut v0, mut v1, mut v2, mut v3) = (v[0] as i32, v[1] as i32, v[2] as i32, v[3] as i32);
                bit_transfer_signed(&mut v1, &mut v0);
                bit_transfer_signed(&mut v3, &mut v2);
                e0 = clamped_rgba([v0, v0, v0, v2]);
                e1 = clamped_rgba([v0 + v1, v0 + v1, v0 + v1, v2 + v3]);
            }
            6 => {
                e0 = [(v[0] * v[3]) >> 8, (v[1] * v[3]) >> 8, (v[2] * v[3]) >> 8, 0xff];
                e1 = [v[0], v[1], v[2], 0xff];
            }
            7 => decode_hdr_endpoint_mode7(&mut e0, &mut e1, v[0], v[1], v[2], v[3]),
            8 => {
                if v[1] + v[3] + v[5] >= v[0] + v[2] + v[4] {
                    e0 = [v[0], v[2], v[4], 0xff];
                    e1 = [v[1], v[3], v[5], 0xff];
                } else {
                    e0 = blue_contract(v[1] as i32, v[3] as i32, v[5] as i32, 0xff).map(|x| x as u32);
                    e1 = blue_contract(v[0] as i32, v[2] as i32, v[4] as i32, 0xff).map(|x| x as u32);
                }
            }
            9 => {
                let (mut v0, mut v1, mut v2, mut v3, mut v4, mut v5) = (
                    v[0] as i32,
                    v[1] as i32,
                    v[2] as i32,
                    v[3] as i32,
                    v[4] as i32,
                    v[5] as i32,
                );
                bit_transfer_signed(&mut v1, &mut v0);
                bit_transfer_signed(&mut v3, &mut v2);
                bit_transfer_signed(&mut v5, &mut v4);

                if v1 + v3 + v5 >= 0 {
                    e0 = clamped_rgba([v0, v2, v4, 0xff]);
                    e1 = clamped_rgba([v0 + v1, v2 + v3, v4 + v5, 0xff]);
                } else {
                    e0 = clamped_rgba(blue_contract(v0 + v1, v2 + v3, v4 + v5, 0xff));
                    e1 = clamped_rgba(blue_contract(v0, v2, v4, 0xff));
                }
            }
            10 => {
                e0 = [(v[0] * v[3]) >> 8, (v[1] * v[3]) >> 8, (v[2] * v[3]) >> 8, v[4]];
                e1 = [v[0], v[1], v[2], v[5]];
            }
            11 => decode_hdr_endpoint_mode11(&mut e0, &mut e1, v[0], v[1], v[2], v[3], v[4], v[5]),
            12 => {
                if v[1] + v[3] + v[5] >= v[0] + v[2] + v[4] {
                    e0 = [v[0], v[2], v[4], v[6]];
                    e1 = [v[1], v[3], v[5], v[7]];
                } else {
                    e0 = clamped_rgba(blue_contract(v[1] as i32, v[3] as i32, v[5] as i32, v[7] as i32));
                    e1 = clamped_rgba(blue_contract(v[0] as i32, v[2] as i32, v[4] as i32, v[6] as i32));
                }
            }
            13 => {
                let (mut v0, mut v1, mut v2, mut v3) = (v[0] as i32, v[1] as i32, v[2] as i32, v[3] as i32);
                let (mut v4, mut v5, mut v6, mut v7) = (v[4] as i32, v[5] as i32, v[6] as i32, v[7] as i32);
                bit_transfer_signed(&mut v1, &mut v0);
                bit_transfer_signed(&mut v3, &mut v2);
                bit_transfer_signed(&mut v5, &mut v4);
                bit_transfer_signed(&mut v7, &mut v6);

                if v1 + v3 + v5 >= 0 {
                    e0 = clamped_rgba([v0, v2, v4, v6]);
                    e1 = clamped_rgba([v0 + v1, v2 + v3, v4 + v5, v6 + v7]);
                } else {
                    e0 = clamped_rgba(blue_contract(v0 + v1, v2 + v3, v4 + v5, v6 + v7));
                    e1 = clamped_rgba(blue_contract(v0, v2, v4, v6));
                }
            }
            14 => {
                decode_hdr_endpoint_mode11(&mut e0, &mut e1, v[0], v[1], v[2], v[3], v[4], v[5]);
                e0[3] = v[6];
                e1[3] = v[7];
            }
            _ => decode_hdr_endpoint_mode15(&mut e0, &mut e1, v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7]),
        }

        dst[partition_ndx] = ColorEndpointPair { e0, e1 };
    }
}

/// `computeColorEndpoints`
fn compute_color_endpoints(
    dst: &mut [ColorEndpointPair; 4],
    block_data: &Block128,
    endpoint_modes: &[u32; 4],
    num_partitions: i32,
    num_color_endpoint_values: i32,
    ise_params: &IseParams,
    num_bits_available: i32,
) {
    let color_endpoint_data_start = if num_partitions == 1 { 17 } else { 29 };
    let mut color_endpoint_data = [IseDecodedResult::default(); 18];

    {
        let mut data_stream = BitAccessStream::new(block_data, color_endpoint_data_start, num_bits_available, true);
        decode_ise(
            &mut color_endpoint_data,
            num_color_endpoint_values,
            &mut data_stream,
            ise_params,
        );
    }

    let mut unquantized_endpoints = [0u32; 18];
    unquantize_color_endpoints(
        &mut unquantized_endpoints,
        &color_endpoint_data,
        num_color_endpoint_values,
        ise_params,
    );
    decode_color_endpoints(dst, &unquantized_endpoints, endpoint_modes, num_partitions);
}

/// `unquantizeWeights`
fn unquantize_weights(dst: &mut [u32; 64], weight_grid: &[IseDecodedResult; 64], block_mode: &AstcBlockMode) {
    let num_weights = compute_num_weights(block_mode) as usize;
    let ise_params = block_mode.weight_ise_params;

    if ise_params.mode == IseMode::Trit || ise_params.mode == IseMode::Quint {
        let range_case = ise_params.num_bits * 2 + i32::from(ise_params.mode == IseMode::Quint);

        if range_case == 0 || range_case == 1 {
            const MAP0: [u32; 3] = [0, 32, 63];
            const MAP1: [u32; 5] = [0, 16, 32, 47, 63];
            let map: &[u32] = if range_case == 0 { &MAP0 } else { &MAP1 };
            for i in 0..num_weights {
                dst[i] = map[weight_grid[i].v as usize];
            }
        } else {
            const CA: [u32; 5] = [50, 28, 23, 13, 11];
            let c = CA[(range_case - 2) as usize];

            for weight_ndx in 0..num_weights {
                let m = weight_grid[weight_ndx].m;
                let (a, b, c_) = (get_bit(m, 0), get_bit(m, 1), get_bit(m, 2));

                let big_a = if a == 0 { 0 } else { (1 << 7) - 1 };
                let big_b = match range_case {
                    2 | 3 => 0,
                    4 => (b << 6) | (b << 2) | b,
                    5 => (b << 6) | (b << 1),
                    _ => (c_ << 6) | (b << 5) | (c_ << 1) | b,
                };

                dst[weight_ndx] = (((weight_grid[weight_ndx].tq * c + big_b) ^ big_a) >> 2) | (big_a & 0x20);
            }
        }
    } else {
        for weight_ndx in 0..num_weights {
            dst[weight_ndx] = bit_replication_scale(weight_grid[weight_ndx].v, ise_params.num_bits, 6);
        }
    }

    for d in dst.iter_mut().take(num_weights) {
        *d += u32::from(*d > 32);
    }

    // Initialize nonexistent weights to poison values.
    for d in dst.iter_mut().skip(num_weights) {
        *d = !0u32;
    }
}

/// `interpolateWeights`
fn interpolate_weights(
    dst: &mut [TexelWeightPair],
    unquantized_weights: &[u32; 64],
    block_width: i32,
    block_height: i32,
    block_mode: &AstcBlockMode,
) {
    let num_weights_per_texel = if block_mode.is_dual_plane { 2 } else { 1 };
    let scale_x = ((1024 + block_width / 2) / (block_width - 1)) as u32;
    let scale_y = ((1024 + block_height / 2) / (block_height - 1)) as u32;

    for texel_y in 0..block_height {
        for texel_x in 0..block_width {
            let g_x = (scale_x * texel_x as u32 * (block_mode.weight_grid_width - 1) as u32 + 32) >> 6;
            let g_y = (scale_y * texel_y as u32 * (block_mode.weight_grid_height - 1) as u32 + 32) >> 6;
            let j_x = g_x >> 4;
            let j_y = g_y >> 4;
            let f_x = g_x & 0xf;
            let f_y = g_y & 0xf;

            // These are uint32_t upstream and the intermediates genuinely wrap: for
            // f_x + f_y > 16, `16 - f_x - f_y` underflows before `+ w11` brings it
            // back. The final sum is modular too, so the wrapped values cancel.
            let w11 = (f_x * f_y + 8) >> 4;
            let w10 = f_y.wrapping_sub(w11);
            let w01 = f_x.wrapping_sub(w11);
            let w00 = 16u32.wrapping_sub(f_x).wrapping_sub(f_y).wrapping_add(w11);

            let i00 = j_y * block_mode.weight_grid_width as u32 + j_x;
            let i01 = i00 + 1;
            let i10 = i00 + block_mode.weight_grid_width as u32;
            let i11 = i00 + block_mode.weight_grid_width as u32 + 1;

            for texel_weight_ndx in 0..num_weights_per_texel {
                // & 0x3f clamps the address to the bounds of unquantized_weights; where
                // that wraps, the matching weight is zero.
                let at = |i: u32| unquantized_weights[((i * num_weights_per_texel + texel_weight_ndx) & 0x3f) as usize];
                let (p00, p01, p10, p11) = (at(i00), at(i01), at(i10), at(i11));

                dst[(texel_y * block_width + texel_x) as usize].w[texel_weight_ndx as usize] = p00
                    .wrapping_mul(w00)
                    .wrapping_add(p01.wrapping_mul(w01))
                    .wrapping_add(p10.wrapping_mul(w10))
                    .wrapping_add(p11.wrapping_mul(w11))
                    .wrapping_add(8)
                    >> 4;
            }
        }
    }
}

/// `interpolateWeights3D`
fn interpolate_weights_3d(
    dst: &mut [TexelWeightPair],
    unquantized_weights: &[u32; 64],
    block_width: i32,
    block_height: i32,
    block_depth: i32,
    block_mode: &AstcBlockMode,
) {
    let num_weights_per_texel: i32 = if block_mode.is_dual_plane { 2 } else { 1 };
    let scale_x = ((1024 + block_width / 2) / (block_width - 1)) as u32;
    let scale_y = ((1024 + block_height / 2) / (block_height - 1)) as u32;
    let scale_z = ((1024 + block_depth / 2) / (block_depth - 1)) as u32;

    for texel_z in 0..block_depth {
        for texel_y in 0..block_height {
            for texel_x in 0..block_width {
                let g_x = (scale_x * texel_x as u32 * (block_mode.weight_grid_width - 1) as u32 + 32) >> 6;
                let g_y = (scale_y * texel_y as u32 * (block_mode.weight_grid_height - 1) as u32 + 32) >> 6;
                let g_z = (scale_z * texel_z as u32 * (block_mode.weight_grid_depth - 1) as u32 + 32) >> 6;
                let (j_x, j_y, j_z) = (g_x >> 4, g_y >> 4, g_z >> 4);
                let (f_x, f_y, f_z) = ((g_x & 0xf) as i32, (g_y & 0xf) as i32, (g_z & 0xf) as i32);

                let (grid_w, grid_h) = (block_mode.weight_grid_width, block_mode.weight_grid_height);
                let mut qweight = [0i32; 4];
                qweight[0] = (j_z as i32 * grid_h + j_y as i32) * grid_w + j_x as i32;
                qweight[3] = ((j_z as i32 + 1) * grid_h + (j_y as i32 + 1)) * grid_w + (j_x as i32 + 1);

                // simplex interpolation
                let cas = (i32::from(f_x > f_y) << 2) + (i32::from(f_y > f_z) << 1) + i32::from(f_x > f_z);
                let n = grid_w;
                let nm = grid_w * grid_h;

                let (s1, s2, w0, w1, w2, w3) = match cas {
                    7 => (1, n, 16 - f_x, f_x - f_y, f_y - f_z, f_z),
                    3 => (n, 1, 16 - f_y, f_y - f_x, f_x - f_z, f_z),
                    5 => (1, nm, 16 - f_x, f_x - f_z, f_z - f_y, f_y),
                    4 => (nm, 1, 16 - f_z, f_z - f_x, f_x - f_y, f_y),
                    2 => (n, nm, 16 - f_y, f_y - f_z, f_z - f_x, f_x),
                    _ => (nm, n, 16 - f_z, f_z - f_y, f_y - f_x, f_x),
                };

                qweight[1] = qweight[0] + s1;
                qweight[2] = qweight[1] + s2;

                for texel_weight_ndx in 0..num_weights_per_texel {
                    // & 0x3f clamps address to bounds of unquantized_weights
                    let at =
                        |q: i32| unquantized_weights[((q * num_weights_per_texel + texel_weight_ndx) & 0x3f) as usize];
                    let (p00, p01, p10, p11) = (at(qweight[0]), at(qweight[1]), at(qweight[2]), at(qweight[3]));

                    dst[(texel_z * block_height * block_width + texel_y * block_width + texel_x) as usize].w
                        [texel_weight_ndx as usize] = p00
                        .wrapping_mul(w0 as u32)
                        .wrapping_add(p01.wrapping_mul(w1 as u32))
                        .wrapping_add(p10.wrapping_mul(w2 as u32))
                        .wrapping_add(p11.wrapping_mul(w3 as u32))
                        .wrapping_add(8)
                        >> 4;
                }
            }
        }
    }
}

/// `computeTexelWeights`
fn compute_texel_weights(
    dst: &mut [TexelWeightPair],
    block_data: &Block128,
    block_width: i32,
    block_height: i32,
    block_depth: i32,
    block_mode: &AstcBlockMode,
) {
    let mut weight_grid = [IseDecodedResult::default(); 64];

    {
        let num_bits = compute_num_required_bits(&block_mode.weight_ise_params, compute_num_weights(block_mode));
        let mut data_stream = BitAccessStream::new(block_data, 127, num_bits, false);
        decode_ise(
            &mut weight_grid,
            compute_num_weights(block_mode),
            &mut data_stream,
            &block_mode.weight_ise_params,
        );
    }

    let mut unquantized_weights = [0u32; 64];
    unquantize_weights(&mut unquantized_weights, &weight_grid, block_mode);
    if block_depth > 1 {
        interpolate_weights_3d(
            dst,
            &unquantized_weights,
            block_width,
            block_height,
            block_depth,
            block_mode,
        );
    } else {
        interpolate_weights(dst, &unquantized_weights, block_width, block_height, block_mode);
    }
}

/// `hash52`
fn hash52(v: u32) -> u32 {
    let mut p = v;
    p ^= p >> 15;
    p = p.wrapping_sub(p << 17);
    p = p.wrapping_add(p << 7);
    p = p.wrapping_add(p << 4);
    p ^= p >> 5;
    p = p.wrapping_add(p << 16);
    p ^= p >> 7;
    p ^= p >> 3;
    p ^= p << 6;
    p ^= p >> 17;
    p
}

/// `computeTexelPartition`
fn compute_texel_partition(
    seed_in: u32,
    x_in: u32,
    y_in: u32,
    z_in: u32,
    num_partitions: i32,
    small_block: bool,
) -> i32 {
    let x = if small_block { x_in << 1 } else { x_in };
    let y = if small_block { y_in << 1 } else { y_in };
    let z = if small_block { z_in << 1 } else { z_in };
    let seed = seed_in + 1024 * (num_partitions - 1) as u32;
    let rnum = hash52(seed);

    let mut seeds: [u8; 12] = [
        (rnum & 0xf) as u8,
        ((rnum >> 4) & 0xf) as u8,
        ((rnum >> 8) & 0xf) as u8,
        ((rnum >> 12) & 0xf) as u8,
        ((rnum >> 16) & 0xf) as u8,
        ((rnum >> 20) & 0xf) as u8,
        ((rnum >> 24) & 0xf) as u8,
        ((rnum >> 28) & 0xf) as u8,
        ((rnum >> 18) & 0xf) as u8,
        ((rnum >> 22) & 0xf) as u8,
        ((rnum >> 26) & 0xf) as u8,
        (((rnum >> 30) | (rnum << 2)) & 0xf) as u8,
    ];
    for s in &mut seeds {
        *s = s.wrapping_mul(*s);
    }

    let sh_a = if seed & 2 != 0 { 4 } else { 5 };
    let sh_b = if num_partitions == 3 { 6 } else { 5 };
    let sh1 = if seed & 1 != 0 { sh_a } else { sh_b };
    let sh2 = if seed & 1 != 0 { sh_b } else { sh_a };
    let sh3 = if seed & 0x10 != 0 { sh1 } else { sh2 };

    for (i, s) in seeds.iter_mut().enumerate() {
        // seeds 1..8 alternate sh1/sh2; 9..12 all take sh3.
        let sh = if i >= 8 {
            sh3
        } else if i % 2 == 0 {
            sh1
        } else {
            sh2
        };
        *s >>= sh;
    }
    let s = seeds.map(u32::from);

    let a = 0x3f
        & s[0]
            .wrapping_mul(x)
            .wrapping_add(s[1].wrapping_mul(y))
            .wrapping_add(s[10].wrapping_mul(z))
            .wrapping_add(rnum >> 14);
    let b = 0x3f
        & s[2]
            .wrapping_mul(x)
            .wrapping_add(s[3].wrapping_mul(y))
            .wrapping_add(s[11].wrapping_mul(z))
            .wrapping_add(rnum >> 10);
    let c = if num_partitions >= 3 {
        0x3f & s[4]
            .wrapping_mul(x)
            .wrapping_add(s[5].wrapping_mul(y))
            .wrapping_add(s[8].wrapping_mul(z))
            .wrapping_add(rnum >> 6)
    } else {
        0
    };
    let d = if num_partitions >= 4 {
        0x3f & s[6]
            .wrapping_mul(x)
            .wrapping_add(s[7].wrapping_mul(y))
            .wrapping_add(s[9].wrapping_mul(z))
            .wrapping_add(rnum >> 2)
    } else {
        0
    };

    if a >= b && a >= c && a >= d {
        0
    } else if b >= c && b >= d {
        1
    } else if c >= d {
        2
    } else {
        3
    }
}

/// `setTexelColors`
#[allow(clippy::too_many_arguments)]
fn set_texel_colors(
    dst: &mut [u8],
    color_endpoints: &[ColorEndpointPair; 4],
    texel_weights: &[TexelWeightPair],
    ccs: i32,
    partition_index_seed: u32,
    num_partitions: i32,
    block_width: i32,
    block_height: i32,
    block_depth: i32,
    is_srgb: bool,
    is_ldr_mode: bool,
    color_endpoint_modes: &[u32; 4],
) -> DecompressResult {
    let small_block = block_width * block_height * block_depth < 31;
    let mut result = DecompressResult::ValidBlock;
    let is_hdr_endpoint: [bool; 4] = std::array::from_fn(|i| is_color_endpoint_mode_hdr(color_endpoint_modes[i]));

    for texel_z in 0..block_depth {
        for texel_y in 0..block_height {
            for texel_x in 0..block_width {
                let texel_ndx = (texel_z * block_width * block_height + texel_y * block_width + texel_x) as usize;
                let color_endpoint_ndx = if num_partitions == 1 {
                    0
                } else {
                    compute_texel_partition(
                        partition_index_seed,
                        texel_x as u32,
                        texel_y as u32,
                        texel_z as u32,
                        num_partitions,
                        small_block,
                    ) as usize
                };
                let e0 = color_endpoints[color_endpoint_ndx].e0;
                let e1 = color_endpoints[color_endpoint_ndx].e1;
                let weight = texel_weights[texel_ndx];

                if is_ldr_mode && is_hdr_endpoint[color_endpoint_ndx] {
                    if is_srgb {
                        dst[texel_ndx * 4..texel_ndx * 4 + 4].copy_from_slice(&[0xff, 0, 0xff, 0xff]);
                    } else {
                        for (c, v) in [1.0f32, 0.0, 1.0, 1.0].into_iter().enumerate() {
                            write_f32(dst, texel_ndx * 4 + c, v);
                        }
                    }
                    result = DecompressResult::Error;
                } else {
                    for channel_ndx in 0..4 {
                        // Alpha for mode 14 is treated the same as LDR.
                        if !is_hdr_endpoint[color_endpoint_ndx]
                            || (channel_ndx == 3 && color_endpoint_modes[color_endpoint_ndx] == 14)
                        {
                            let c0 = (e0[channel_ndx] << 8) | if is_srgb { 0x80 } else { e0[channel_ndx] };
                            let c1 = (e1[channel_ndx] << 8) | if is_srgb { 0x80 } else { e1[channel_ndx] };
                            let w = weight.w[usize::from(ccs == channel_ndx as i32)];
                            let c = (c0 * (64 - w) + c1 * w + 32) / 64;

                            if is_srgb {
                                dst[texel_ndx * 4 + channel_ndx] = ((c & 0xff00) >> 8) as u8;
                            } else {
                                write_f32(
                                    dst,
                                    texel_ndx * 4 + channel_ndx,
                                    if c == 65535 { 1.0 } else { c as f32 / 65536.0 },
                                );
                            }
                        } else {
                            let c0 = e0[channel_ndx] << 4;
                            let c1 = e1[channel_ndx] << 4;
                            let w = weight.w[usize::from(ccs == channel_ndx as i32)];
                            let c = (c0 * (64 - w) + c1 * w + 32) / 64;
                            let e = get_bits(c, 11, 15);
                            let m = get_bits(c, 0, 10);
                            let mt = if m < 512 {
                                3 * m
                            } else if m >= 1536 {
                                5 * m - 2048
                            } else {
                                4 * m - 512
                            };
                            let cf = ((e << 10) + (mt >> 3)) as u16;

                            write_f32(
                                dst,
                                texel_ndx * 4 + channel_ndx,
                                crate::tcu::pixel::f16_bits_to_f32(if is_float16_inf_or_nan(cf) { 0x7bff } else { cf }),
                            );
                        }
                    }
                }
            }
        }
    }

    result
}

/// `decompressBlock`
fn decompress_block(
    dst: &mut [u8],
    block_data: &Block128,
    block_width: i32,
    block_height: i32,
    block_depth: i32,
    is_srgb: bool,
    is_ldr: bool,
) -> DecompressResult {
    let block_mode = if block_depth > 1 {
        get_astc_block_mode_3d(block_data.get_bits(0, 10))
    } else {
        get_astc_block_mode(block_data.get_bits(0, 10))
    };

    if block_mode.is_error {
        set_astc_error_color_block(
            dst,
            block_width as usize,
            block_height as usize,
            block_depth as usize,
            is_srgb,
        );
        return DecompressResult::Error;
    }

    if block_mode.is_void_extent {
        return decode_void_extent_block(
            dst,
            block_data,
            block_width as usize,
            block_height as usize,
            block_depth as usize,
            is_srgb,
            is_ldr,
        );
    }

    let num_weights = compute_num_weights(&block_mode);
    let num_weight_data_bits = compute_num_required_bits(&block_mode.weight_ise_params, num_weights);
    let num_partitions = block_data.get_bits(11, 12) as i32 + 1;

    if num_weights > 64
        || num_weight_data_bits > 96
        || num_weight_data_bits < 24
        || block_mode.weight_grid_width > block_width
        || block_mode.weight_grid_depth > block_depth
        || block_mode.weight_grid_height > block_height
        || (num_partitions == 4 && block_mode.is_dual_plane)
    {
        set_astc_error_color_block(
            dst,
            block_width as usize,
            block_height as usize,
            block_depth as usize,
            is_srgb,
        );
        return DecompressResult::Error;
    }

    let is_single_unique_cem = num_partitions == 1 || block_data.get_bits(23, 24) == 0;
    let num_config_data_bits = (if num_partitions == 1 {
        17
    } else if is_single_unique_cem {
        29
    } else {
        25 + 3 * num_partitions
    }) + if block_mode.is_dual_plane { 2 } else { 0 };
    let num_bits_for_color_endpoints = 128 - num_weight_data_bits - num_config_data_bits;
    let extra_cem_bits_start = 127
        - num_weight_data_bits
        - if is_single_unique_cem {
            -1
        } else if num_partitions == 4 {
            7
        } else if num_partitions == 3 {
            4
        } else {
            1
        };

    let mut color_endpoint_modes = [0u32; 4];
    decode_color_endpoint_modes(
        &mut color_endpoint_modes,
        block_data,
        num_partitions,
        extra_cem_bits_start as u32,
    );

    let num_color_endpoint_values = compute_num_color_endpoint_values(&color_endpoint_modes, num_partitions);

    if num_color_endpoint_values > 18 || num_bits_for_color_endpoints < div_round_up(13 * num_color_endpoint_values, 5)
    {
        set_astc_error_color_block(
            dst,
            block_width as usize,
            block_height as usize,
            block_depth as usize,
            is_srgb,
        );
        return DecompressResult::Error;
    }

    let mut color_endpoints = [ColorEndpointPair::default(); 4];
    compute_color_endpoints(
        &mut color_endpoints,
        block_data,
        &color_endpoint_modes,
        num_partitions,
        num_color_endpoint_values,
        &compute_maximum_range_ise_params(num_bits_for_color_endpoints, num_color_endpoint_values),
        num_bits_for_color_endpoints,
    );

    let mut texel_weights = [TexelWeightPair::default(); MAX_BLOCK_TEXELS];
    compute_texel_weights(
        &mut texel_weights,
        block_data,
        block_width,
        block_height,
        block_depth,
        &block_mode,
    );

    let ccs = if block_mode.is_dual_plane {
        block_data.get_bits((extra_cem_bits_start - 2) as u32, (extra_cem_bits_start - 1) as u32) as i32
    } else {
        -1
    };
    let partition_index_seed = if num_partitions > 1 {
        block_data.get_bits(13, 22)
    } else {
        u32::MAX
    };

    set_texel_colors(
        dst,
        &color_endpoints,
        &texel_weights,
        ccs,
        partition_index_seed,
        num_partitions,
        block_width,
        block_height,
        block_depth,
        is_srgb,
        is_ldr,
        &color_endpoint_modes,
    )
}

/// `astc::decompress` and `astc::decompress3D` - one block into a `block_width` x `block_height` x `block_depth` access.
pub fn decompress_block_to(dst: &mut PixelBufferAccess<'_>, data: &[u8], is_srgb: bool, is_ldr: bool) {
    let [block_width, block_height, block_depth] = dst.size();
    let (block_width, block_height, block_depth) = (block_width as i32, block_height as i32, block_depth as i32);

    // The sRGB path writes bytes and the linear one writes floats; upstream shares one
    // union for both, and this shares one byte buffer sized for the larger.
    let mut buffer = vec![0u8; MAX_BLOCK_TEXELS * 4 * 4];

    let block_data = Block128::new(data);
    decompress_block(
        &mut buffer,
        &block_data,
        block_width,
        block_height,
        block_depth,
        is_srgb,
        is_ldr,
    );

    for z in 0..block_depth {
        for i in 0..block_height {
            for j in 0..block_width {
                let at = (((z * block_height * block_width) + i * block_width + j) * 4) as usize;
                if is_srgb {
                    let px = [
                        buffer[at] as i32,
                        buffer[at + 1] as i32,
                        buffer[at + 2] as i32,
                        buffer[at + 3] as i32,
                    ];
                    let _ = dst.set_pixel_int(px, j as u32, i as u32, z as u32);
                } else {
                    let px: [f32; 4] = std::array::from_fn(|c| {
                        f32::from_ne_bytes(buffer[(at + c) * 4..(at + c) * 4 + 4].try_into().unwrap())
                    });
                    dst.set_pixel(px, j as u32, i as u32, z as u32);
                }
            }
        }
    }
}

/// `tritBlockTValue` - a value of T that decodes back to the given five trits.
const TRIT_BLOCK_T_VALUE: [u32; 243] = [
    0, 128, 96, 32, 160, 224, 64, 192, 28, 16, 144, 112, 48, 176, 240, 80, 208, 156, 3, 131, 99, 35, 163, 227, 67, 195,
    31, 4, 132, 100, 36, 164, 228, 68, 196, 60, 20, 148, 116, 52, 180, 244, 84, 212, 188, 19, 147, 115, 51, 179, 243,
    83, 211, 159, 8, 136, 104, 40, 168, 232, 72, 200, 92, 24, 152, 120, 56, 184, 248, 88, 216, 220, 12, 140, 108, 44,
    172, 236, 76, 204, 124, 1, 129, 97, 33, 161, 225, 65, 193, 29, 17, 145, 113, 49, 177, 241, 81, 209, 157, 7, 135,
    103, 39, 167, 231, 71, 199, 63, 5, 133, 101, 37, 165, 229, 69, 197, 61, 21, 149, 117, 53, 181, 245, 85, 213, 189,
    23, 151, 119, 55, 183, 247, 87, 215, 191, 9, 137, 105, 41, 169, 233, 73, 201, 93, 25, 153, 121, 57, 185, 249, 89,
    217, 221, 13, 141, 109, 45, 173, 237, 77, 205, 125, 2, 130, 98, 34, 162, 226, 66, 194, 30, 18, 146, 114, 50, 178,
    242, 82, 210, 158, 11, 139, 107, 43, 171, 235, 75, 203, 95, 6, 134, 102, 38, 166, 230, 70, 198, 62, 22, 150, 118,
    54, 182, 246, 86, 214, 190, 27, 155, 123, 59, 187, 251, 91, 219, 223, 10, 138, 106, 42, 170, 234, 74, 202, 94, 26,
    154, 122, 58, 186, 250, 90, 218, 222, 14, 142, 110, 46, 174, 238, 78, 206, 126,
];

/// `quintBlockQValue` - a value of Q that decodes back to the given three quints.
const QUINT_BLOCK_Q_VALUE: [u32; 125] = [
    0, 32, 64, 96, 102, 8, 40, 72, 104, 110, 16, 48, 80, 112, 118, 24, 56, 88, 120, 126, 5, 37, 69, 101, 39, 1, 33, 65,
    97, 103, 9, 41, 73, 105, 111, 17, 49, 81, 113, 119, 25, 57, 89, 121, 127, 13, 45, 77, 109, 47, 2, 34, 66, 98, 70,
    10, 42, 74, 106, 78, 18, 50, 82, 114, 86, 26, 58, 90, 122, 94, 21, 53, 85, 117, 55, 3, 35, 67, 99, 71, 11, 43, 75,
    107, 79, 19, 51, 83, 115, 87, 27, 59, 91, 123, 95, 29, 61, 93, 125, 63, 4, 36, 68, 100, 38, 12, 44, 76, 108, 46,
    20, 52, 84, 116, 54, 28, 60, 92, 124, 62, 6, 14, 22, 30, 7,
];

// ---------------------------------------------------------------------------------
// Block generation
//
// A blit test needs source blocks that are *valid*, because the comparison has no
// meaning for a block the decoder rejects, so the generator and the decoder both have
// to be here: `generate_random_valid_blocks` rolls blocks until one decodes cleanly.
// ---------------------------------------------------------------------------------

/// `AssignBlock128` - the write-side counterpart of `Block128`.
#[derive(Clone, Copy, Default)]
struct AssignBlock128 {
    words: [u64; 2],
}

impl AssignBlock128 {
    fn set_bit(&mut self, ndx: i32, val: u32) {
        let word_ndx = (ndx / 64) as usize;
        let bit_ndx = ndx % 64;
        self.words[word_ndx] = (self.words[word_ndx] & !(1u64 << bit_ndx)) | (u64::from(val) << bit_ndx);
    }

    fn set_bits(&mut self, low: i32, high: i32, bits: u32) {
        if high < low {
            return;
        }
        let word0_ndx = (low / 64) as usize;
        let word1_ndx = (high / 64) as usize;
        let low_ndx_in_w0 = low % 64;

        if word0_ndx == word1_ndx {
            let mask = (((1u64 << (high - low)) << 1) - 1) << low_ndx_in_w0;
            self.words[word0_ndx] = (self.words[word0_ndx] & !mask) | (u64::from(bits) << low_ndx_in_w0);
        } else {
            let high_ndx_in_w1 = high % 64;
            let num_bits_to_set_in_w0 = 64 - low_ndx_in_w0;
            let bits_low_mask = (1u64 << num_bits_to_set_in_w0) - 1;

            self.words[word0_ndx] = (self.words[word0_ndx] & ((1u64 << low_ndx_in_w0) - 1))
                | ((u64::from(bits) & bits_low_mask) << low_ndx_in_w0);
            self.words[word1_ndx] = (self.words[word1_ndx] & !(((1u64 << high_ndx_in_w1) << 1) - 1))
                | ((u64::from(bits) & !bits_low_mask) >> num_bits_to_set_in_w0);
        }
    }

    fn assign_to_memory(&self, dst: &mut [u8]) {
        for (word_ndx, word) in self.words.iter().enumerate() {
            for byte_ndx in 0..8 {
                dst[word_ndx * 8 + byte_ndx] = ((word >> (8 * byte_ndx)) & 0xff) as u8;
            }
        }
    }
}

/// `BitAssignAccessStream`
struct BitAssignAccessStream<'a> {
    dst: &'a mut AssignBlock128,
    start_ndx_in_src: i32,
    length: i32,
    forward: bool,
    ndx: i32,
}

impl<'a> BitAssignAccessStream<'a> {
    fn new(dst: &'a mut AssignBlock128, start_ndx_in_src: i32, length: i32, forward: bool) -> Self {
        Self {
            dst,
            start_ndx_in_src,
            length,
            forward,
            ndx: 0,
        }
    }

    /// Set the next `num` bits. Bits at or past `m_length` are not touched.
    fn set_next(&mut self, num: i32, bits: u32) {
        if num == 0 || self.ndx >= self.length {
            return;
        }
        let end = self.ndx + num;
        let num_bits_to_dst = 0.max(self.length.min(end) - self.ndx);
        let low = self.ndx;
        let high = self.ndx + num_bits_to_dst - 1;
        let actual_bits = get_bits(bits, 0, (num_bits_to_dst - 1) as u32);

        self.ndx += num;

        if self.forward {
            self.dst
                .set_bits(self.start_ndx_in_src + low, self.start_ndx_in_src + high, actual_bits);
        } else {
            self.dst.set_bits(
                self.start_ndx_in_src - high,
                self.start_ndx_in_src - low,
                reverse_bits(actual_bits, num_bits_to_dst as u32),
            );
        }
    }
}

/// `VoidExtentParams`
struct VoidExtentParams {
    is_hdr: bool,
    r: u16,
    g: u16,
    b: u16,
    a: u16,
}

/// `generateVoidExtentBlock`
fn generate_void_extent_block(params: &VoidExtentParams) -> AssignBlock128 {
    let mut block = AssignBlock128::default();

    block.set_bits(0, 8, 0x1fc); // Marks void-extent block.
    block.set_bit(9, u32::from(params.is_hdr));
    block.set_bits(10, 11, 3); // The spec sets both, although they serve no purpose.

    // Extent coordinates - currently all-ones.
    block.set_bits(12, 24, 0x1fff);
    block.set_bits(25, 37, 0x1fff);
    block.set_bits(38, 50, 0x1fff);
    block.set_bits(51, 63, 0x1fff);

    block.set_bits(64, 79, u32::from(params.r));
    block.set_bits(80, 95, u32::from(params.g));
    block.set_bits(96, 111, u32::from(params.b));
    block.set_bits(112, 127, u32::from(params.a));

    block
}

/// `ISEInput` - either plain values in the ISE range, or explicit block specifications.
#[derive(Clone, Copy, Default)]
struct IseInputBlock {
    /// The 8-bit T or 7-bit Q in a trit or quint ISE block.
    t_or_q_value: u32,
    bit_values: [u32; 5],
}

struct IseInput {
    is_given_in_block_form: bool,
    plain: [u32; 64],
    block: [IseInputBlock; 64],
}

impl Default for IseInput {
    fn default() -> Self {
        Self {
            is_given_in_block_form: false,
            plain: [0; 64],
            block: [IseInputBlock::default(); 64],
        }
    }
}

fn compute_ise_range_max(ise_params: &IseParams) -> u32 {
    match ise_params.mode {
        IseMode::Trit => (1u32 << ise_params.num_bits) * 3 - 1,
        IseMode::Quint => (1u32 << ise_params.num_bits) * 5 - 1,
        IseMode::PlainBit => (1u32 << ise_params.num_bits) - 1,
        IseMode::Last => unreachable!("ISE mode not set"),
    }
}

/// `NormalBlockParams`
#[derive(Clone, Copy)]
struct NormalBlockParams {
    weight_grid_width: i32,
    weight_grid_height: i32,
    weight_grid_depth: i32,
    weight_ise_params: IseParams,
    is_dual_plane: bool,
    /// Irrelevant if !is_dual_plane.
    ccs: u32,
    num_partitions: i32,
    color_endpoint_modes: [u32; 4],
    // The rest is irrelevant if num_partitions == 1.
    /// If true, the single CEM is at color_endpoint_modes[0].
    is_multi_part_single_cem_mode: bool,
    partition_seed: u32,
}

impl Default for NormalBlockParams {
    fn default() -> Self {
        Self {
            weight_grid_width: -1,
            weight_grid_height: -1,
            weight_grid_depth: -1,
            weight_ise_params: IseParams::new(IseMode::Last, -1),
            is_dual_plane: true,
            ccs: u32::MAX,
            num_partitions: -1,
            color_endpoint_modes: [0; 4],
            is_multi_part_single_cem_mode: false,
            partition_seed: u32::MAX,
        }
    }
}

#[derive(Default)]
struct NormalBlockIseInputs {
    weight: IseInput,
    endpoint: IseInput,
}

fn compute_num_weights_params(params: &NormalBlockParams) -> i32 {
    params.weight_grid_width
        * params.weight_grid_height
        * params.weight_grid_depth
        * if params.is_dual_plane { 2 } else { 1 }
}

fn compute_num_bits_for_color_endpoints(params: &NormalBlockParams) -> i32 {
    let num_weight_bits = compute_num_required_bits(&params.weight_ise_params, compute_num_weights_params(params));
    let num_config_data_bits = (if params.num_partitions == 1 {
        17
    } else if params.is_multi_part_single_cem_mode {
        29
    } else {
        25 + 3 * params.num_partitions
    }) + if params.is_dual_plane { 2 } else { 0 };

    128 - num_weight_bits - num_config_data_bits
}

fn compute_num_color_endpoint_values_params(
    endpoint_modes: &[u32; 4],
    num_partitions: i32,
    is_multi_part_single_cem_mode: bool,
) -> i32 {
    if is_multi_part_single_cem_mode {
        num_partitions * compute_num_color_endpoint_values_for_mode(endpoint_modes[0])
    } else {
        (0..num_partitions as usize)
            .map(|i| compute_num_color_endpoint_values_for_mode(endpoint_modes[i]))
            .sum()
    }
}

/// `isValidBlockParams`
fn is_valid_block_params(params: &NormalBlockParams, block_width: i32, block_height: i32, block_depth: i32) -> bool {
    let num_weights = compute_num_weights_params(params);
    let num_weight_bits = compute_num_required_bits(&params.weight_ise_params, num_weights);
    let num_color_endpoint_values = compute_num_color_endpoint_values_params(
        &params.color_endpoint_modes,
        params.num_partitions,
        params.is_multi_part_single_cem_mode,
    );
    let num_bits_for_color_endpoints = compute_num_bits_for_color_endpoints(params);

    num_weights <= 64
        && (24..=96).contains(&num_weight_bits)
        && params.weight_grid_width <= block_width
        && params.weight_grid_depth <= block_depth
        && params.weight_grid_height <= block_height
        && !(params.num_partitions == 4 && params.is_dual_plane)
        && num_color_endpoint_values <= 18
        && num_bits_for_color_endpoints >= div_round_up(13 * num_color_endpoint_values, 5)
}

/// The `isAstc3D` half of `writeBlockMode`: the 3D block mode layouts with their a, b and c variable terms.
fn write_block_mode_3d(dst: &mut AssignBlock128, block_params: &NormalBlockParams, d: u32, r: u32, h: u32) {
    const Z: usize = 0;
    const A: usize = 1;
    const B: usize = 2;
    const C: usize = 3;
    // (aNumBits, bNumBits, cNumBits, widthVar, widthConst, heightVar, heightConst, depthVar, depthConst)
    const LAYOUTS: [(i32, i32, i32, usize, i32, usize, i32, usize, i32); 7] = [
        (2, 2, 2, B, 2, C, 2, A, 2),
        (0, 0, 0, Z, 6, Z, 2, Z, 2),
        (0, 0, 0, Z, 2, Z, 6, Z, 2),
        (0, 0, 0, Z, 2, Z, 2, Z, 6),
        (2, 0, 2, Z, 6, C, 2, A, 2),
        (2, 0, 2, A, 2, Z, 6, C, 2),
        (2, 0, 2, A, 2, C, 2, Z, 6),
    ];

    // Index 0 is where the terms that do not vary write to; a, b and c stay all ones when no layout assigns them.
    let mut variables = [0u32, u32::MAX, u32::MAX, u32::MAX];
    let mut layout_ndx = LAYOUTS.len();

    for (ndx, &(a_bits, b_bits, c_bits, width_var, width_const, height_var, height_const, depth_var, depth_const)) in
        LAYOUTS.iter().enumerate()
    {
        let offsets_max = [0, (1 << a_bits) - 1, (1 << b_bits) - 1, (1 << c_bits) - 1];
        if (width_const..=width_const + offsets_max[width_var]).contains(&block_params.weight_grid_width)
            && (height_const..=height_const + offsets_max[height_var]).contains(&block_params.weight_grid_height)
            && (depth_const..=depth_const + offsets_max[depth_var]).contains(&block_params.weight_grid_depth)
        {
            variables[width_var] = (block_params.weight_grid_width - width_const) as u32;
            variables[height_var] = (block_params.weight_grid_height - height_const) as u32;
            variables[depth_var] = (block_params.weight_grid_depth - depth_const) as u32;
            layout_ndx = ndx;
            break;
        }
    }

    let (a, b, c) = (variables[A], variables[B], variables[C]);
    let (a0, a1, b0, b1, c0, c1) = (
        get_bit(a, 0),
        get_bit(a, 1),
        get_bit(b, 0),
        get_bit(b, 1),
        get_bit(c, 0),
        get_bit(c, 1),
    );
    let (r0, r1, r2) = (get_bit(r, 0), get_bit(r, 1), get_bit(r, 2));

    // Bits 10 down to 0, as upstream's ASSIGN_BITS lists them.
    let bits: [u32; 11] = match layout_ndx {
        0 => [d, h, c1, c0, b1, b0, r0, a1, a0, r2, r1],
        1 => [d, h, 1, 1, 0, 0, r0, r2, r1, 0, 0],
        2 => [d, h, 1, 1, 0, 1, r0, r2, r1, 0, 0],
        3 => [d, h, 1, 1, 1, 0, r0, r2, r1, 0, 0],
        4 => [c1, c0, 0, 0, b1, b0, r0, r2, r1, 0, 0],
        5 => [c1, c0, 0, 1, b1, b0, r0, r2, r1, 0, 0],
        _ => [c1, c0, 1, 0, b1, b0, r0, r2, r1, 0, 0],
    };
    for (i, &bit) in bits.iter().enumerate() {
        dst.set_bit(10 - i as i32, bit);
    }
}

/// `writeBlockMode` - bits 0 to 10 of an ASTC block.
fn write_block_mode(dst: &mut AssignBlock128, block_params: &NormalBlockParams, is_astc_3d: bool) {
    let d = u32::from(block_params.is_dual_plane);

    let (r, h) = match compute_ise_range_max(&block_params.weight_ise_params) {
        1 => (2, 0),
        2 => (3, 0),
        3 => (4, 0),
        4 => (5, 0),
        5 => (6, 0),
        7 => (7, 0),
        9 => (2, 1),
        11 => (3, 1),
        15 => (4, 1),
        19 => (5, 1),
        23 => (6, 1),
        _ => (7, 1),
    };

    if is_astc_3d {
        write_block_mode_3d(dst, block_params, d, r, h);
        return;
    }

    // `BlockModeLayoutABVariable`: which of a/b (or neither) the grid dimension varies with.
    const Z: usize = 0;
    const A: usize = 1;
    const B: usize = 2;
    // (aNumBits, bNumBits, widthVar, widthConst, heightVar, heightConst)
    const BLOCK_MODE_LAYOUTS: [(i32, i32, usize, i32, usize, i32); 10] = [
        (2, 2, B, 4, A, 2),
        (2, 2, B, 8, A, 2),
        (2, 2, A, 2, B, 8),
        (2, 1, A, 2, B, 6),
        (2, 1, B, 2, A, 2),
        (2, 0, Z, 12, A, 2),
        (2, 0, A, 2, Z, 12),
        (0, 0, Z, 6, Z, 10),
        (0, 0, Z, 10, Z, 6),
        (2, 2, A, 6, B, 6),
    ];

    let mut a = u32::MAX;
    let mut b = u32::MAX;
    let mut block_mode_layout_ndx = BLOCK_MODE_LAYOUTS.len();

    for (ndx, &(a_num_bits, b_num_bits, width_var, width_const, height_var, height_const)) in
        BLOCK_MODE_LAYOUTS.iter().enumerate()
    {
        let a_max = (1 << a_num_bits) - 1;
        let b_max = (1 << b_num_bits) - 1;
        let variable_offsets_max = [0, a_max, b_max];
        let width_min = width_const;
        let height_min = height_const;
        let width_max = width_min + variable_offsets_max[width_var];
        let height_max = height_min + variable_offsets_max[height_var];

        if (width_min..=width_max).contains(&block_params.weight_grid_width)
            && (height_min..=height_max).contains(&block_params.weight_grid_height)
        {
            let mut default_value = 0u32;
            {
                let width_variable: &mut u32 = match width_var {
                    A => &mut a,
                    B => &mut b,
                    _ => &mut default_value,
                };
                *width_variable = (block_params.weight_grid_width - width_const) as u32;
            }
            let height_variable: &mut u32 = match height_var {
                A => &mut a,
                B => &mut b,
                _ => &mut default_value,
            };
            *height_variable = (block_params.weight_grid_height - height_const) as u32;

            block_mode_layout_ndx = ndx;
            break;
        }
    }

    let a0 = get_bit(a, 0);
    let a1 = get_bit(a, 1);
    let b0 = get_bit(b, 0);
    let b1 = get_bit(b, 1);
    let r0 = get_bit(r, 0);
    let r1 = get_bit(r, 1);
    let r2 = get_bit(r, 2);

    // Bits 10 down to 0, in that order, exactly as upstream's ASSIGN_BITS macro lists them.
    let bits: [u32; 11] = match block_mode_layout_ndx {
        0 => [d, h, b1, b0, a1, a0, r0, 0, 0, r2, r1],
        1 => [d, h, b1, b0, a1, a0, r0, 0, 1, r2, r1],
        2 => [d, h, b1, b0, a1, a0, r0, 1, 0, r2, r1],
        3 => [d, h, 0, b, a1, a0, r0, 1, 1, r2, r1],
        4 => [d, h, 1, b, a1, a0, r0, 1, 1, r2, r1],
        5 => [d, h, 0, 0, a1, a0, r0, r2, r1, 0, 0],
        6 => [d, h, 0, 1, a1, a0, r0, r2, r1, 0, 0],
        7 => [d, h, 1, 1, 0, 0, r0, r2, r1, 0, 0],
        8 => [d, h, 1, 1, 0, 1, r0, r2, r1, 0, 0],
        _ => [b1, b0, 1, 0, a1, a0, r0, r2, r1, 0, 0],
    };
    for (i, &bit) in bits.iter().enumerate() {
        dst.set_bit(10 - i as i32, bit);
    }
}

/// `writeColorEndpointModes`
fn write_color_endpoint_modes(
    dst: &mut AssignBlock128,
    color_endpoint_modes: &[u32; 4],
    is_multi_part_single_cem_mode: bool,
    num_partitions: i32,
    extra_cem_bits_start: i32,
) {
    if num_partitions == 1 {
        dst.set_bits(13, 16, color_endpoint_modes[0]);
    } else if is_multi_part_single_cem_mode {
        dst.set_bits(23, 24, 0);
        dst.set_bits(25, 28, color_endpoint_modes[0]);
    } else {
        let max_cem = *color_endpoint_modes[..num_partitions as usize]
            .iter()
            .max()
            .expect("num_partitions > 0");
        let max_cem_class = max_cem / 4;
        let high_level_selector = 1.max(max_cem_class);

        dst.set_bits(23, 24, high_level_selector);

        for part_ndx in 0..num_partitions {
            let c = u32::from(color_endpoint_modes[part_ndx as usize] / 4 == high_level_selector);
            let m = color_endpoint_modes[part_ndx as usize] % 4;
            let low_m_bit0_ndx = num_partitions + 2 * part_ndx;
            let low_m_bit1_ndx = num_partitions + 2 * part_ndx + 1;
            dst.set_bit(25 + part_ndx, c);
            dst.set_bit(
                if low_m_bit0_ndx < 4 {
                    25 + low_m_bit0_ndx
                } else {
                    extra_cem_bits_start + low_m_bit0_ndx - 4
                },
                get_bit(m, 0),
            );
            dst.set_bit(
                if low_m_bit1_ndx < 4 {
                    25 + low_m_bit1_ndx
                } else {
                    extra_cem_bits_start + low_m_bit1_ndx - 4
                },
                get_bit(m, 1),
            );
        }
    }
}

/// `encodeISETritBlock`
fn encode_ise_trit_block(
    dst: &mut BitAssignAccessStream<'_>,
    num_bits: i32,
    from_explicit_input_block: bool,
    block_input: &IseInputBlock,
    non_block_input: &[u32],
    num_values: i32,
) {
    let mut trit_parts = [0u32; 5];
    let mut bit_parts = [0u32; 5];

    for i in 0..5 {
        if i < num_values as usize {
            if from_explicit_input_block {
                bit_parts[i] = block_input.bit_values[i];
            } else {
                bit_parts[i] = if num_bits > 0 {
                    get_bits(non_block_input[i], 0, (num_bits - 1) as u32)
                } else {
                    0
                };
                trit_parts[i] = non_block_input[i] >> num_bits;
            }
        }
    }

    let t = if from_explicit_input_block {
        block_input.t_or_q_value
    } else {
        let ndx = trit_parts[0] * 81 + trit_parts[1] * 27 + trit_parts[2] * 9 + trit_parts[3] * 3 + trit_parts[4];
        TRIT_BLOCK_T_VALUE[ndx as usize]
    };

    dst.set_next(num_bits, bit_parts[0]);
    dst.set_next(2, get_bits(t, 0, 1));
    dst.set_next(num_bits, bit_parts[1]);
    dst.set_next(2, get_bits(t, 2, 3));
    dst.set_next(num_bits, bit_parts[2]);
    dst.set_next(1, get_bit(t, 4));
    dst.set_next(num_bits, bit_parts[3]);
    dst.set_next(2, get_bits(t, 5, 6));
    dst.set_next(num_bits, bit_parts[4]);
    dst.set_next(1, get_bit(t, 7));
}

/// `encodeISEQuintBlock`
fn encode_ise_quint_block(
    dst: &mut BitAssignAccessStream<'_>,
    num_bits: i32,
    from_explicit_input_block: bool,
    block_input: &IseInputBlock,
    non_block_input: &[u32],
    num_values: i32,
) {
    let mut quint_parts = [0u32; 3];
    let mut bit_parts = [0u32; 3];

    for i in 0..3 {
        if i < num_values as usize {
            if from_explicit_input_block {
                bit_parts[i] = block_input.bit_values[i];
            } else {
                bit_parts[i] = if num_bits > 0 {
                    get_bits(non_block_input[i], 0, (num_bits - 1) as u32)
                } else {
                    0
                };
                quint_parts[i] = non_block_input[i] >> num_bits;
            }
        }
    }

    let q = if from_explicit_input_block {
        block_input.t_or_q_value
    } else {
        QUINT_BLOCK_Q_VALUE[(quint_parts[0] * 25 + quint_parts[1] * 5 + quint_parts[2]) as usize]
    };

    dst.set_next(num_bits, bit_parts[0]);
    dst.set_next(3, get_bits(q, 0, 2));
    dst.set_next(num_bits, bit_parts[1]);
    dst.set_next(2, get_bits(q, 3, 4));
    dst.set_next(num_bits, bit_parts[2]);
    dst.set_next(2, get_bits(q, 5, 6));
}

/// `encodeISE`
fn encode_ise(dst: &mut BitAssignAccessStream<'_>, params: &IseParams, input: &IseInput, num_values: i32) {
    const EMPTY: IseInputBlock = IseInputBlock {
        t_or_q_value: 0,
        bit_values: [0; 5],
    };
    match params.mode {
        IseMode::Trit => {
            let num_blocks = div_round_up(num_values, 5);
            for block_ndx in 0..num_blocks {
                let num_values_in_block = if block_ndx == num_blocks - 1 {
                    num_values - 5 * (num_blocks - 1)
                } else {
                    5
                };
                let block = if input.is_given_in_block_form {
                    input.block[block_ndx as usize]
                } else {
                    EMPTY
                };
                let plain = if input.is_given_in_block_form {
                    &[][..]
                } else {
                    &input.plain[5 * block_ndx as usize..]
                };
                encode_ise_trit_block(
                    dst,
                    params.num_bits,
                    input.is_given_in_block_form,
                    &block,
                    plain,
                    num_values_in_block,
                );
            }
        }
        IseMode::Quint => {
            let num_blocks = div_round_up(num_values, 3);
            for block_ndx in 0..num_blocks {
                let num_values_in_block = if block_ndx == num_blocks - 1 {
                    num_values - 3 * (num_blocks - 1)
                } else {
                    3
                };
                let block = if input.is_given_in_block_form {
                    input.block[block_ndx as usize]
                } else {
                    EMPTY
                };
                let plain = if input.is_given_in_block_form {
                    &[][..]
                } else {
                    &input.plain[3 * block_ndx as usize..]
                };
                encode_ise_quint_block(
                    dst,
                    params.num_bits,
                    input.is_given_in_block_form,
                    &block,
                    plain,
                    num_values_in_block,
                );
            }
        }
        _ => {
            for i in 0..num_values as usize {
                let value = if input.is_given_in_block_form {
                    input.block[i].bit_values[0]
                } else {
                    input.plain[i]
                };
                dst.set_next(params.num_bits, value);
            }
        }
    }
}

/// `generateNormalBlock`
fn generate_normal_block(block_params: &NormalBlockParams, ise_inputs: &NormalBlockIseInputs) -> AssignBlock128 {
    let mut block = AssignBlock128::default();
    let num_weights = compute_num_weights_params(block_params);
    let num_weight_bits = compute_num_required_bits(&block_params.weight_ise_params, num_weights);

    write_block_mode(&mut block, block_params, block_params.weight_grid_depth > 1);

    block.set_bits(11, 12, (block_params.num_partitions - 1) as u32);
    if block_params.num_partitions > 1 {
        block.set_bits(13, 22, block_params.partition_seed);
    }

    let extra_cem_bits_start = 127
        - num_weight_bits
        - if block_params.num_partitions == 1 || block_params.is_multi_part_single_cem_mode {
            -1
        } else if block_params.num_partitions == 4 {
            7
        } else if block_params.num_partitions == 3 {
            4
        } else {
            1
        };

    write_color_endpoint_modes(
        &mut block,
        &block_params.color_endpoint_modes,
        block_params.is_multi_part_single_cem_mode,
        block_params.num_partitions,
        extra_cem_bits_start,
    );

    if block_params.is_dual_plane {
        block.set_bits(extra_cem_bits_start - 2, extra_cem_bits_start - 1, block_params.ccs);
    }

    // writeWeightData
    {
        let mut access = BitAssignAccessStream::new(&mut block, 127, num_weight_bits, false);
        encode_ise(
            &mut access,
            &block_params.weight_ise_params,
            &ise_inputs.weight,
            num_weights,
        );
    }

    // writeColorEndpointData
    {
        let num_color_endpoint_values = compute_num_color_endpoint_values_params(
            &block_params.color_endpoint_modes,
            block_params.num_partitions,
            block_params.is_multi_part_single_cem_mode,
        );
        let num_bits_for_color_endpoints = compute_num_bits_for_color_endpoints(block_params);
        let color_endpoint_data_start_ndx = if block_params.num_partitions == 1 { 17 } else { 29 };
        let color_endpoint_ise_params =
            compute_maximum_range_ise_params(num_bits_for_color_endpoints, num_color_endpoint_values);

        let mut access = BitAssignAccessStream::new(
            &mut block,
            color_endpoint_data_start_ndx,
            num_bits_for_color_endpoints,
            true,
        );
        encode_ise(
            &mut access,
            &color_endpoint_ise_params,
            &ise_inputs.endpoint,
            num_color_endpoint_values,
        );
    }

    block
}

/// `s_weightISEParamsCandidates`
const WEIGHT_ISE_PARAMS_CANDIDATES: [IseParams; 12] = [
    IseParams::new(IseMode::PlainBit, 1),
    IseParams::new(IseMode::Trit, 0),
    IseParams::new(IseMode::PlainBit, 2),
    IseParams::new(IseMode::Quint, 0),
    IseParams::new(IseMode::Trit, 1),
    IseParams::new(IseMode::PlainBit, 3),
    IseParams::new(IseMode::Quint, 1),
    IseParams::new(IseMode::Trit, 2),
    IseParams::new(IseMode::PlainBit, 4),
    IseParams::new(IseMode::Quint, 2),
    IseParams::new(IseMode::Trit, 3),
    IseParams::new(IseMode::PlainBit, 5),
];

/// `generateRandomBlock`
fn generate_random_block(dst: &mut [u8], block_size: [i32; 3], rnd: &mut Random) {
    if rnd.get_float() < 0.1 {
        // Void extent block.
        let is_void_extent_hdr = rnd.get_bool();
        let component = |rnd: &mut Random| {
            if is_void_extent_hdr {
                crate::tcu::pixel::f32_to_f16_bits(rnd.get_float_range(0.0, 1.0))
            } else {
                rnd.get_int(0, 0xffff) as u16
            }
        };
        let r = component(rnd);
        let g = component(rnd);
        let b = component(rnd);
        let a = component(rnd);
        generate_void_extent_block(&VoidExtentParams {
            is_hdr: is_void_extent_hdr,
            r,
            g,
            b,
            a,
        })
        .assign_to_memory(dst);
        return;
    }

    // Not void extent block. Generate block params.
    let mut block_params = NormalBlockParams::default();

    loop {
        block_params.weight_grid_width = rnd.get_int(2, block_size[0]);
        block_params.weight_grid_height = rnd.get_int(2, block_size[1]);
        block_params.weight_grid_depth = if block_size[2] > 1 {
            rnd.get_int(2, block_size[2])
        } else {
            1
        };
        block_params.weight_ise_params =
            WEIGHT_ISE_PARAMS_CANDIDATES[rnd.get_int(0, WEIGHT_ISE_PARAMS_CANDIDATES.len() as i32 - 1) as usize];
        block_params.num_partitions = rnd.get_int(1, 4);
        block_params.is_multi_part_single_cem_mode = rnd.get_float() < 0.25;
        block_params.is_dual_plane = block_params.num_partitions != 4 && rnd.get_bool();
        block_params.ccs = rnd.get_int(0, 3) as u32;
        block_params.partition_seed = rnd.get_int(0, 1023) as u32;

        block_params.color_endpoint_modes[0] = rnd.get_int(0, 15) as u32;

        let cem_diff = if block_params.is_multi_part_single_cem_mode {
            0
        } else if block_params.color_endpoint_modes[0] == 0 {
            1
        } else if block_params.color_endpoint_modes[0] == 15 {
            -1
        } else if rnd.get_bool() {
            1
        } else {
            -1
        };

        for i in 1..block_params.num_partitions as usize {
            let delta = match cem_diff {
                -1 => rnd.get_int(-1, 0),
                1 => rnd.get_int(0, 1),
                _ => 0,
            };
            block_params.color_endpoint_modes[i] = (block_params.color_endpoint_modes[0] as i32 + delta) as u32;
        }

        if is_valid_block_params(&block_params, block_size[0], block_size[1], block_size[2]) {
            break;
        }
    }

    // Generate ISE inputs for both weight and endpoint data.
    let mut ise_inputs = NormalBlockIseInputs::default();

    for weight_or_endpoints in 0..=1 {
        let set_weights = weight_or_endpoints == 0;
        let num_values = if set_weights {
            compute_num_weights_params(&block_params)
        } else {
            compute_num_color_endpoint_values_params(
                &block_params.color_endpoint_modes,
                block_params.num_partitions,
                block_params.is_multi_part_single_cem_mode,
            )
        };
        let ise_params = if set_weights {
            block_params.weight_ise_params
        } else {
            compute_maximum_range_ise_params(compute_num_bits_for_color_endpoints(&block_params), num_values)
        };
        let ise_input = if set_weights {
            &mut ise_inputs.weight
        } else {
            &mut ise_inputs.endpoint
        };

        ise_input.is_given_in_block_form = rnd.get_bool();

        if ise_input.is_given_in_block_form {
            let num_values_per_ise_block = match ise_params.mode {
                IseMode::Trit => 5,
                IseMode::Quint => 3,
                _ => 1,
            };
            let ise_bit_max = (1 << ise_params.num_bits) - 1;
            let num_ise_blocks = div_round_up(num_values, num_values_per_ise_block);

            for ise_block_ndx in 0..num_ise_blocks as usize {
                ise_input.block[ise_block_ndx].t_or_q_value = rnd.get_int(0, 255) as u32;
                for i in 0..num_values_per_ise_block as usize {
                    ise_input.block[ise_block_ndx].bit_values[i] = rnd.get_int(0, ise_bit_max) as u32;
                }
            }
        } else {
            let range_max = compute_ise_range_max(&ise_params) as i32;
            for value_ndx in 0..num_values as usize {
                ise_input.plain[value_ndx] = rnd.get_int(0, range_max) as u32;
            }
        }
    }

    generate_normal_block(&block_params, &ise_inputs).assign_to_memory(dst);
}

/// `isValidBlock` - whether the block decodes without hitting the error path.
#[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
fn is_valid_block(data: &[u8], block_width: i32, block_height: i32, is_srgb: bool, is_ldr: bool) -> bool {
    is_valid_block_3d(data, [block_width, block_height, 1], is_srgb, is_ldr)
}

/// `isValidBlock` for a block of any depth.
fn is_valid_block_3d(data: &[u8], block_size: [i32; 3], is_srgb: bool, is_ldr: bool) -> bool {
    let mut tmp_buffer = vec![0u8; MAX_BLOCK_TEXELS * 4 * 4];
    let block_data = Block128::new(data);
    decompress_block(
        &mut tmp_buffer,
        &block_data,
        block_size[0],
        block_size[1],
        block_size[2],
        is_srgb,
        is_ldr,
    ) == DecompressResult::ValidBlock
}

/// `generateRandomValidBlocks`
pub fn generate_random_valid_blocks(
    dst: &mut [u8],
    num_blocks: usize,
    block_width: u32,
    block_height: u32,
    is_srgb: bool,
    is_ldr: bool,
    seed: u32,
) {
    generate_random_valid_blocks_3d(dst, num_blocks, [block_width, block_height, 1], is_srgb, is_ldr, seed);
}

/// `generateRandomValidBlocks` for a block of any depth (the 3D ASTC formats).
pub fn generate_random_valid_blocks_3d(
    dst: &mut [u8],
    num_blocks: usize,
    block_pixel_size: [u32; 3],
    is_srgb: bool,
    is_ldr: bool,
    seed: u32,
) {
    let block_size = block_pixel_size.map(|size| size as i32);
    let mut rnd = Random::new(seed);

    for block_ndx in 0..num_blocks {
        let cur_block = &mut dst[block_ndx * BLOCK_SIZE_BYTES..(block_ndx + 1) * BLOCK_SIZE_BYTES];
        loop {
            generate_random_block(cur_block, block_size, &mut rnd);
            if is_valid_block_3d(cur_block, block_size, is_srgb, is_ldr) {
                break;
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn ldr_format() -> TextureFormat {
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::HALF_FLOAT)
    }

    /// A void-extent block carries one colour for the whole block, so it is the one
    /// case whose decoded output can be predicted without reimplementing the decoder.
    #[test]
    fn void_extent_block_is_flat() {
        let block = generate_void_extent_block(&VoidExtentParams {
            is_hdr: false,
            r: 0x8000,
            g: 0,
            b: 0xffff,
            a: 0xffff,
        });
        let mut data = [0u8; BLOCK_SIZE_BYTES];
        block.assign_to_memory(&mut data);

        let mut level = TextureLevel::new(ldr_format(), 4, 4, 1).unwrap();
        decompress_block_to(&mut level.get_access(), &data, false, true);

        let access = level.get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let px = access.get_pixel(x, y, 0);
                assert_eq!(px[0], 0.5, "red at ({x}, {y})");
                assert_eq!(px[1], 0.0, "green at ({x}, {y})");
                assert_eq!(px[2], 1.0, "blue at ({x}, {y})");
                assert_eq!(px[3], 1.0, "alpha at ({x}, {y})");
            }
        }
    }

    /// The generator's contract: every block it produces decodes without the error
    /// path, for each block size and for both sRGB and linear.
    #[test]
    fn every_generated_block_is_valid() {
        for (w, h) in [(4u32, 4u32), (5, 4), (6, 5), (8, 8), (10, 6), (12, 12)] {
            for is_srgb in [false, true] {
                const COUNT: usize = 64;
                let mut data = vec![0u8; COUNT * BLOCK_SIZE_BYTES];
                generate_random_valid_blocks(&mut data, COUNT, w, h, is_srgb, true, 123);

                for (i, block) in data.chunks(BLOCK_SIZE_BYTES).enumerate() {
                    assert!(
                        is_valid_block(block, w as i32, h as i32, is_srgb, true),
                        "block {i} of {w}x{h} srgb={is_srgb}"
                    );
                }
            }
        }
    }

    /// The same seed has to give the same blocks, or the reference the host builds
    /// stops matching the source the device was handed.
    #[test]
    fn generation_is_deterministic() {
        let mut a = vec![0u8; 16 * BLOCK_SIZE_BYTES];
        let mut b = vec![0u8; 16 * BLOCK_SIZE_BYTES];
        generate_random_valid_blocks(&mut a, 16, 6, 6, false, true, 4321);
        generate_random_valid_blocks(&mut b, 16, 6, 6, false, true, 4321);
        assert_eq!(a, b);
    }
}
