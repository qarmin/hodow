// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFmaTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 Arm Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 324 cases (`getFmaCode`) is in `shaders/manifest/spirv_assembly_fma.toml` (written by
// `scripts/gen_spirv_assembly_fma_manifest.py`); the `spec` of a case carries the width, the vector size, the rounding and denorm modes, whether
// SignedZeroInfNanPreserve is used and the input mode. `std::fma` under a changed `fenv` rounding mode (and the `double` detour of the half version)
// is replaced by an exact fused multiply-add on integers (`fma`), rounded to the format in each of the four directed modes; everything else
// (`getRefValues`, `getAllowedInputs`, the special values, the cancellation inputs, `verifyResult`) follows the C++.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::utils::{float16_to_float32, float32_to_float16};
use crate::generated::shaders::spirv_assembly_fma::ALL_FMA_CASE;
use crate::tcu::random::{Random, de_string_hash};
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

/// The `rust_type` of the manifest entries: one `FmaCase`.
#[derive(Clone, Copy)]
pub struct FmaCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

const NUM_RANDOM_INPUTS: usize = 768;
const MAX_ERRORS: usize = 16;

#[derive(Clone, Copy, PartialEq, Eq)]
enum RoundingMode {
    Rtz,
    Rte,
    Undef,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DenormMode {
    Preserve,
    Flush,
    Undef,
}

/// The directed rounding modes of the exact arithmetic.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Round {
    TowardZero,
    NearestEven,
    TowardPositive,
    TowardNegative,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum InputMode {
    Random,
    Directed,
}

/// A binary floating point format; values travel as their bits in a `u64`.
#[derive(Clone, Copy)]
struct Fmt {
    bits: u32,
    mant_bits: u32,
    exp_bits: u32,
}

const F16: Fmt = Fmt {
    bits: 16,
    mant_bits: 10,
    exp_bits: 5,
};
const F32: Fmt = Fmt {
    bits: 32,
    mant_bits: 23,
    exp_bits: 8,
};
const F64: Fmt = Fmt {
    bits: 64,
    mant_bits: 52,
    exp_bits: 11,
};

impl Fmt {
    fn size(self) -> usize {
        (self.bits / 8) as usize
    }

    fn bias(self) -> i32 {
        (1i32 << (self.exp_bits - 1)) - 1
    }

    fn precision(self) -> i32 {
        self.mant_bits as i32 + 1
    }

    fn emin(self) -> i32 {
        1 - self.bias()
    }

    fn exp_max(self) -> u64 {
        (1u64 << self.exp_bits) - 1
    }

    fn sign_bit(self) -> u64 {
        1u64 << (self.bits - 1)
    }

    fn frac_mask(self) -> u64 {
        (1u64 << self.mant_bits) - 1
    }

    fn exp_field(self, x: u64) -> u64 {
        (x >> self.mant_bits) & self.exp_max()
    }

    fn is_nan(self, x: u64) -> bool {
        self.exp_field(x) == self.exp_max() && x & self.frac_mask() != 0
    }

    fn is_inf(self, x: u64) -> bool {
        self.exp_field(x) == self.exp_max() && x & self.frac_mask() == 0
    }

    fn is_zero(self, x: u64) -> bool {
        x & !self.sign_bit() == 0
    }

    fn is_denorm(self, x: u64) -> bool {
        self.exp_field(x) == 0 && x & self.frac_mask() != 0
    }

    fn is_inf_nan(self, x: u64) -> bool {
        self.exp_field(x) == self.exp_max()
    }

    fn negate(self, x: u64) -> u64 {
        x ^ self.sign_bit()
    }

    fn quiet_nan(self) -> u64 {
        (self.exp_max() << self.mant_bits) | (1u64 << (self.mant_bits - 1))
    }

    fn inf(self, negative: bool) -> u64 {
        (self.exp_max() << self.mant_bits) | if negative { self.sign_bit() } else { 0 }
    }
}

/// A finite nonzero value: `(-1)^neg * mant * 2^exp`.
#[derive(Clone, Copy)]
struct Finite {
    neg: bool,
    mant: u128,
    exp: i32,
}

fn unpack(fmt: Fmt, x: u64) -> Option<Finite> {
    let neg = x & fmt.sign_bit() != 0;
    let frac = x & fmt.frac_mask();
    let exponent = fmt.exp_field(x) as i32;
    let (mant, exp) = if exponent == 0 {
        (frac, fmt.emin() - fmt.mant_bits as i32)
    } else {
        (
            frac | (1u64 << fmt.mant_bits),
            exponent - fmt.bias() - fmt.mant_bits as i32,
        )
    };
    if mant == 0 {
        None
    } else {
        Some(Finite {
            neg,
            mant: u128::from(mant),
            exp,
        })
    }
}

/// The mantissa shifted so that its top bit is bit 120, and the exponent that goes with it.
fn normalized(v: &Finite) -> (bool, u128, i32) {
    let shift = v.mant.leading_zeros() as i32 - 7;
    (v.neg, v.mant << shift as u32, v.exp - shift)
}

fn shift_right_jam(v: u128, d: u32) -> u128 {
    if d == 0 {
        v
    } else if d >= 128 {
        u128::from(v != 0)
    } else {
        (v >> d) | u128::from(v & ((1u128 << d) - 1) != 0)
    }
}

/// The exact sum of two values as sign, magnitude and exponent, with a sticky bit in the lowest bit of the magnitude when the smaller
/// operand was far below; `None` for an exact zero.
fn add_exact(a: Option<Finite>, b: Option<Finite>) -> Option<(bool, u128, i32)> {
    match (a, b) {
        (None, None) => None,
        (Some(x), None) | (None, Some(x)) => Some(normalized(&x)),
        (Some(x), Some(y)) => {
            let nx = normalized(&x);
            let ny = normalized(&y);
            let ((neg_big, mant_big, exp_big), (neg_small, mant_small, exp_small)) =
                if ny.2 > nx.2 || (ny.2 == nx.2 && ny.1 > nx.1) {
                    (ny, nx)
                } else {
                    (nx, ny)
                };
            let mant_small = shift_right_jam(mant_small, (exp_big - exp_small) as u32);
            if neg_big == neg_small {
                Some((neg_big, mant_big + mant_small, exp_big))
            } else {
                let diff = mant_big - mant_small;
                if diff == 0 {
                    None
                } else {
                    Some((neg_big, diff, exp_big))
                }
            }
        }
    }
}

/// `r * 2^e` (r nonzero) rounded to the format in the given mode.
fn round_pack(fmt: Fmt, neg: bool, r: u128, e: i32, mode: Round) -> u64 {
    let top = 127 - r.leading_zeros() as i32;
    let precision = fmt.precision();
    let q = (e + top - (precision - 1)).max(fmt.emin() - (precision - 1));
    let shift = q - e;

    let mant: u128 = if shift <= 0 {
        r << (-shift) as u32
    } else {
        let (quotient, remainder_cmp, inexact) = if shift >= 128 {
            (0u128, std::cmp::Ordering::Less, true)
        } else {
            let shift = shift as u32;
            let remainder = r & ((1u128 << shift) - 1);
            let half = 1u128 << (shift - 1);
            (r >> shift, remainder.cmp(&half), remainder != 0)
        };
        let increment = match mode {
            Round::TowardZero => false,
            Round::NearestEven => {
                remainder_cmp == std::cmp::Ordering::Greater
                    || (remainder_cmp == std::cmp::Ordering::Equal && quotient & 1 == 1)
            }
            Round::TowardPositive => !neg && inexact,
            Round::TowardNegative => neg && inexact,
        };
        quotient + u128::from(increment)
    };

    let sign = if neg { fmt.sign_bit() } else { 0 };
    if mant == 0 {
        return sign;
    }
    let hidden = 1u64 << fmt.mant_bits;
    let mut mant = mant as u64;
    let mut q = q;
    if mant >= hidden * 2 {
        mant >>= 1;
        q += 1;
    }
    if mant < hidden {
        return sign | mant;
    }
    let biased = q + fmt.mant_bits as i32 + fmt.bias();
    if biased >= fmt.exp_max() as i32 {
        let to_inf = match mode {
            Round::NearestEven => true,
            Round::TowardZero => false,
            Round::TowardPositive => !neg,
            Round::TowardNegative => neg,
        };
        let max_finite = ((fmt.exp_max() - 1) << fmt.mant_bits) | fmt.frac_mask();
        return sign | if to_inf { fmt.inf(false) } else { max_finite };
    }
    sign | ((biased as u64) << fmt.mant_bits) | (mant & fmt.frac_mask())
}

/// `std::fma` with the rounding of `mode`, on the bits of the format.
fn fma(fmt: Fmt, a: u64, b: u64, c: u64, mode: Round) -> u64 {
    if fmt.is_nan(a) || fmt.is_nan(b) || fmt.is_nan(c) {
        return fmt.quiet_nan();
    }
    let product_negative = (a ^ b) & fmt.sign_bit() != 0;
    let addend_negative = c & fmt.sign_bit() != 0;
    if fmt.is_inf(a) || fmt.is_inf(b) {
        if fmt.is_zero(a) || fmt.is_zero(b) {
            return fmt.quiet_nan();
        }
        if fmt.is_inf(c) && addend_negative != product_negative {
            return fmt.quiet_nan();
        }
        return fmt.inf(product_negative);
    }
    if fmt.is_inf(c) {
        return c;
    }

    let product = match (unpack(fmt, a), unpack(fmt, b)) {
        (Some(x), Some(y)) => Some(Finite {
            neg: x.neg != y.neg,
            mant: x.mant * y.mant,
            exp: x.exp + y.exp,
        }),
        _ => None,
    };
    let addend = unpack(fmt, c);
    let both_zero = product.is_none() && addend.is_none();
    match add_exact(product, addend) {
        Some((neg, r, e)) => round_pack(fmt, neg, r, e, mode),
        None => {
            let negative = if both_zero && product_negative == addend_negative {
                product_negative
            } else {
                mode == Round::TowardNegative
            };
            if negative { fmt.sign_bit() } else { 0 }
        }
    }
}

fn is_valid(fmt: Fmt, a: u64, b: u64) -> bool {
    a == b || (fmt.is_nan(a) && fmt.is_nan(b))
}

/// `getValidFlushedValues`
fn get_valid_flushed_values(fmt: Fmt, a: u64, d: DenormMode) -> Vec<u64> {
    let mut valid = vec![a];
    if fmt.is_denorm(a) && d != DenormMode::Preserve {
        valid.push(0);
        valid.push(fmt.negate(0));
    }
    valid
}

/// `getAllowedInputs`
fn get_allowed_inputs(fmt: Fmt, a: u64, b: u64, c: u64, d: DenormMode) -> Vec<[u64; 3]> {
    let mut allowed = Vec::new();
    for in_a in get_valid_flushed_values(fmt, a, d) {
        for in_b in get_valid_flushed_values(fmt, b, d) {
            for in_c in get_valid_flushed_values(fmt, c, d) {
                allowed.push([in_a, in_b, in_c]);
            }
        }
    }
    allowed
}

/// `getRefValues`
fn get_ref_values(fmt: Fmt, a: u64, b: u64, c: u64, m: RoundingMode, d: DenormMode, signed_zero: bool) -> Vec<u64> {
    let mut ret = Vec::new();
    let allowed_rounding_modes: &[Round] = match m {
        RoundingMode::Rtz => &[Round::TowardZero],
        RoundingMode::Rte => &[Round::NearestEven],
        RoundingMode::Undef => &[Round::TowardPositive, Round::TowardNegative],
    };

    let allowed_inputs = get_allowed_inputs(fmt, a, b, c, d);
    for &mode in allowed_rounding_modes {
        for inp in &allowed_inputs {
            let r = fma(fmt, inp[0], inp[1], inp[2], mode);
            let r_down = fma(fmt, inp[0], inp[1], inp[2], Round::TowardNegative);
            let r_up = fma(fmt, inp[0], inp[1], inp[2], Round::TowardPositive);

            let underflow_after_rounding = fmt.is_denorm(r);
            let underflow_before_rounding = fmt.is_denorm(r_up) || fmt.is_denorm(r_down);

            if d != DenormMode::Flush || !underflow_after_rounding {
                ret.push(r);
            }
            if d != DenormMode::Preserve && underflow_before_rounding {
                ret.push(0);
                ret.push(fmt.negate(0));
            }
            if fmt.is_zero(r) && !signed_zero {
                ret.push(fmt.negate(r));
            }
        }
    }
    ret
}

/// `UsesInfNan`
fn uses_inf_nan(fmt: Fmt, r: &[u64], a: u64, b: u64, c: u64) -> bool {
    fmt.is_inf_nan(a) || fmt.is_inf_nan(b) || fmt.is_inf_nan(c) || r.iter().any(|&res| fmt.is_inf_nan(res))
}

fn read_value(buffer: &[u8], ndx: usize, size: usize) -> u64 {
    let mut bytes = [0u8; 8];
    bytes[..size].copy_from_slice(&buffer[ndx * size..(ndx + 1) * size]);
    u64::from_le_bytes(bytes)
}

/// `verify<T, m, d, szInfNan>` (`verifyResult`), with the type, the modes and the flag packed into `K` as `((width * 3 + m) * 3 + d) * 2 + szInfNan`.
fn verify<const K: usize>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected_outputs: &[Vec<u8>]) -> bool {
    let sz_inf_nan = K % 2 == 1;
    let d = [DenormMode::Preserve, DenormMode::Flush, DenormMode::Undef][(K / 2) % 3];
    let m = [RoundingMode::Rtz, RoundingMode::Rte, RoundingMode::Undef][(K / 6) % 3];
    let fmt = [F16, F32, F64][K / 18];
    let size = fmt.size();

    let count = inputs[0].len() / size;
    let mut errors = 0usize;
    for ndx in 0..count {
        let a = read_value(&inputs[0], ndx, size);
        let b = read_value(&inputs[1], ndx, size);
        let c = read_value(&inputs[2], ndx, size);
        let ref_values = get_ref_values(fmt, a, b, c, m, d, sz_inf_nan);

        if !sz_inf_nan && uses_inf_nan(fmt, &ref_values, a, b, c) {
            continue;
        }

        let result = read_value(&outputs[0], ndx, size);
        if !ref_values.iter().any(|&reference| is_valid(fmt, result, reference)) {
            errors += 1;
            if errors >= MAX_ERRORS {
                break;
            }
        }
    }
    errors == 0
}

fn verify_for(k: usize) -> VerifyIo {
    macro_rules! table {
        ($($k:literal)*) => {
            match k {
                $($k => verify::<$k> as VerifyIo,)*
                _ => unreachable!("fma verifier index"),
            }
        };
    }
    table!(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53)
}

/// `getRandomVal<T>`
fn random_val(fmt: Fmt, rnd: &mut Random) -> u64 {
    match fmt.bits {
        16 => u64::from(0x0400u16 + rnd.get_uint16() % (0x7BFFu16 - 0x0400u16 + 1)),
        32 => u64::from(rnd.get_float_range(0.0001f32, 10000.0f32).to_bits()),
        _ => rnd
            .get_double_range(f64::from(0.0001f32), f64::from(10000.0f32))
            .to_bits(),
    }
}

/// `GetSpecialValues<T>`
fn special_values(fmt: Fmt) -> &'static [u64] {
    const HALF: [u64; 38] = [
        0x7C01, 0x7C00, 0x7BFF, 0x5C01, 0x5C00, 0x5BFF, 0x5801, 0x5800, 0x57FF, 0x4201, 0x4200, 0x41FF, 0x4100, 0x4000,
        0x3f00, 0x3E01, 0x3E00, 0x3DFF, 0x3D00, 0x3C20, 0x3C30, 0x3C02, 0x3C01, 0x3C00, 0x3BFF, 0x0401, 0x0400, 0x03FF,
        0x007F, 0x001F, 0x0007, 0x0006, 0x0005, 0x0004, 0x0003, 0x0002, 0x0001, 0x0000,
    ];
    const SINGLE: [u64; 38] = [
        0x7FC00000, 0x7F800000, 0x7F7FFFFF, 0x5F800001, 0x5F800000, 0x5F7FFFFF, 0x5F000001, 0x5F000000, 0x5EFFFFFF,
        0x40400001, 0x40400000, 0x403FFFFF, 0x40200000, 0x40000000, 0x3FE00000, 0x3FC00001, 0x3FC00000, 0x3FBFFFFF,
        0x3FA00000, 0x3F801800, 0x3F800800, 0x3F800002, 0x3F800001, 0x3F800000, 0x3F7FFFFF, 0x00800001, 0x00800000,
        0x007FFFFF, 0x000007FF, 0x0000007F, 0x00000007, 0x00000006, 0x00000005, 0x00000004, 0x00000003, 0x00000002,
        0x00000001, 0x00000000,
    ];
    const DOUBLE: [u64; 37] = [
        0x7FF8000000000000,
        0x7FF0000000000000,
        0x7FEFFFFFFFFFFFFF,
        0x5FF0000000000001,
        0x5FF0000000000000,
        0x5FF8000000000000,
        0x5FE0000000000000,
        0x5FDFFFFFFFFFFFFF,
        0x4008000000000001,
        0x4008000000000000,
        0x4007FFFFFFFFFFFF,
        0x4004000000000000,
        0x4000000000000000,
        0x3FFC000000000000,
        0x3FF8000000000001,
        0x3FF8000000000000,
        0x3FF7FFFFFFFFFFFF,
        0x3FF4000000000000,
        0x3FF0000006000000,
        0x3FF0000004000000,
        0x3FF0000000000002,
        0x3FF0000000000001,
        0x3FF0000000000000,
        0x3FEFFFFFFFFFFFFF,
        0x0010000000000001,
        0x0010000000000000,
        0x000FFFFFFFFFFFFF,
        0x0000000000000FF7,
        0x00000000000000F7,
        0x0000000000000007,
        0x0000000000000006,
        0x0000000000000005,
        0x0000000000000004,
        0x0000000000000003,
        0x0000000000000002,
        0x0000000000000001,
        0x0000000000000000,
    ];
    match fmt.bits {
        16 => &HALF,
        32 => &SINGLE,
        _ => &DOUBLE,
    }
}

/// `getCancellationValue<T>`: `-(a * b)`, the half version through `float`.
fn cancellation_value(fmt: Fmt, a: u64, b: u64) -> u64 {
    match fmt.bits {
        16 => u64::from(float32_to_float16(
            -(float16_to_float32(a as u16) * float16_to_float32(b as u16)),
        )),
        32 => u64::from((-(f32::from_bits(a as u32) * f32::from_bits(b as u32))).to_bits()),
        _ => (-(f64::from_bits(a) * f64::from_bits(b))).to_bits(),
    }
}

fn push_value(bytes: &mut Vec<u8>, value: u64, size: usize) {
    bytes.extend_from_slice(&value.to_le_bytes()[..size]);
}

/// `RandomBuffer<T>::getBytes`
fn random_buffer(fmt: Fmt, num_values: usize, seed: u32) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let mut bytes = Vec::with_capacity(num_values * fmt.size());
    for _ in 0..num_values {
        let value = random_val(fmt, &mut rnd);
        push_value(&mut bytes, value, fmt.size());
    }
    bytes
}

fn num_special_value_cases(fmt: Fmt) -> usize {
    let num_values = 2 * special_values(fmt).len();
    num_values * num_values * num_values
}

/// `DirectedBuffer<T>::NumCancellationCases`
fn num_cancellation_cases(fmt: Fmt, vec_sz: usize) -> usize {
    let min_cancellation_cases = 100usize;
    let mut total_cases = num_special_value_cases(fmt) + min_cancellation_cases;
    if total_cases % vec_sz != 0 {
        total_cases += vec_sz - (total_cases % vec_sz);
    }
    if total_cases / vec_sz > 65536 {
        total_cases += vec_sz * 65536 - (total_cases % (vec_sz * 65536));
    }
    total_cases - num_special_value_cases(fmt)
}

/// `DirectedBuffer<T>::getBytes`
fn directed_buffer(fmt: Fmt, channel: usize, vec_sz: usize) -> Vec<u8> {
    let size = fmt.size();
    let mut bytes = Vec::new();

    let mut values = Vec::new();
    for &f in special_values(fmt) {
        values.push(f);
        values.push(fmt.negate(f));
    }
    let num_consecutive = match channel {
        0 => values.len() * values.len(),
        1 => values.len(),
        _ => 1,
    };
    let num_reps = values.len() * values.len() / num_consecutive;
    for _ in 0..num_reps {
        for &v in &values {
            for _ in 0..num_consecutive {
                push_value(&mut bytes, v, size);
            }
        }
    }

    let num_cancellation = num_cancellation_cases(fmt, vec_sz);
    let mut cancellation: [Vec<u64>; 2] = [Vec::new(), Vec::new()];
    for (i, values) in cancellation.iter_mut().enumerate() {
        if channel != i && channel != 2 {
            continue;
        }
        let mut rnd = Random::new(de_string_hash("fma.directed_inputs_cancellation").wrapping_add(i as u32));
        for _ in 0..num_cancellation {
            values.push(random_val(fmt, &mut rnd));
        }
    }
    for j in 0..num_cancellation {
        let value = if channel == 2 {
            cancellation_value(fmt, cancellation[0][j], cancellation[1][j])
        } else {
            cancellation[channel][j]
        };
        push_value(&mut bytes, value, size);
    }
    bytes
}

struct Params {
    fmt: Fmt,
    vec_sz: usize,
    rounding: RoundingMode,
    denorm: DenormMode,
    sz_inf_nan: bool,
    input_mode: InputMode,
}

fn parse(spec: &str) -> Params {
    let field = |key: &str| -> &str {
        spec.split(';')
            .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
            .unwrap_or_else(|| panic!("fma spec without {key}"))
    };
    Params {
        fmt: match field("bits") {
            "16" => F16,
            "32" => F32,
            _ => F64,
        },
        vec_sz: field("vec").parse().expect("a vector size"),
        rounding: match field("m") {
            "rtz" => RoundingMode::Rtz,
            "rte" => RoundingMode::Rte,
            _ => RoundingMode::Undef,
        },
        denorm: match field("d") {
            "preserve" => DenormMode::Preserve,
            "flush" => DenormMode::Flush,
            _ => DenormMode::Undef,
        },
        sz_inf_nan: field("sz") == "1",
        input_mode: if field("mode") == "random" {
            InputMode::Random
        } else {
            InputMode::Directed
        },
    }
}

/// `FillFloatControlsProps`, as the float controls properties the device must have: the first and the rest.
fn float_controls_properties(params: &Params) -> Vec<(u32, &'static str)> {
    let bits = params.fmt.bits;
    let mut properties = Vec::new();
    match params.rounding {
        RoundingMode::Rtz => properties.push((bits, "RoundingModeRTZ")),
        RoundingMode::Rte => properties.push((bits, "RoundingModeRTE")),
        RoundingMode::Undef => {}
    }
    match params.denorm {
        DenormMode::Preserve => properties.push((bits, "DenormPreserve")),
        DenormMode::Flush => properties.push((bits, "DenormFlushToZero")),
        DenormMode::Undef => {}
    }
    if params.sz_inf_nan {
        properties.push((bits, "SignedZeroInfNanPreserve"));
    }
    properties
}

/// `createFmaTestSpec`
fn make_case(case: &FmaCase, leaf: &str) -> Box<dyn TestCase> {
    let params = parse(case.spec);
    let fmt = params.fmt;

    let inputs: Vec<Vec<u8>> = match params.input_mode {
        InputMode::Random => {
            let mut rnd = Random::new(de_string_hash("fma.random_inputs"));
            let seeds = [rnd.get_uint32(), rnd.get_uint32(), rnd.get_uint32()];
            seeds
                .iter()
                .map(|&seed| random_buffer(fmt, NUM_RANDOM_INPUTS, seed))
                .collect()
        }
        InputMode::Directed => (0..3)
            .map(|channel| directed_buffer(fmt, channel, params.vec_sz))
            .collect(),
    };
    let buf_size = inputs[0].len();
    let num_elements = buf_size / fmt.size();
    assert!(num_elements % params.vec_sz == 0);
    let num_threads = (num_elements / params.vec_sz) as u32;
    let x = num_threads.min(65536);
    let y = if num_threads == 0 {
        0
    } else {
        (num_threads - 1) / 65536 + 1
    };

    let mut features = Vec::new();
    match fmt.bits {
        16 => features.push(RequiredFeature::ShaderFloat16),
        64 => features.push(RequiredFeature::ShaderFloat64),
        _ => {}
    }
    let mut properties = float_controls_properties(&params).into_iter();
    let float_controls_property = properties.next();
    let extra_float_controls_properties: Vec<(u32, &'static str)> = properties.collect();

    let k = ((match fmt.bits {
        16 => 0,
        32 => 1,
        _ => 2,
    } * 3
        + match params.rounding {
            RoundingMode::Rtz => 0,
            RoundingMode::Rte => 1,
            RoundingMode::Undef => 2,
        })
        * 3
        + match params.denorm {
            DenormMode::Preserve => 0,
            DenormMode::Flush => 1,
            DenormMode::Undef => 2,
        })
        * 2
        + usize::from(params.sz_inf_nan);

    let spec = ComputeShaderSpec {
        inputs,
        outputs: vec![vec![0u8; buf_size]],
        num_work_groups: [x, y, 1],
        features,
        fma_float_bits: fmt.bits,
        float_controls_property,
        extra_float_controls_properties,
        verify_io: Some(verify_for(k)),
        fail_message: "Output doesn't match with expected",
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// `createOpFmaComputeGroup`, as the groups of each case path below `compute` and the case.
pub fn create_fma_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_FMA_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
