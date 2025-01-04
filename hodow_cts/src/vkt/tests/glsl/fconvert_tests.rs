// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderFConvertTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 Valve Corporation.
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are written by `scripts/gen_fconvert_manifest.py` (`shaders/manifest/shader_fconvert.toml`); the case runs through the
// compute case of the assembly groups, whose buffers are the two SSBOs. The `tcu::Float<...>` template is `Fl` here, one struct that carries the format (the
// template's parameters) as data, `tcu::FloatMXINT8` is `Value::MxInt8`, and the inputs are drawn from one `de::Random` in the order `InputGenerator` draws them, the
// per-type random normals being made on the first request as upstream's function-local statics are. `verify_io` is a plain function pointer, so the parameters of the
// case travel in 16 bytes after the packed input (past the end of the SSBO array); the failure log lines of `validConversion` are dropped. Out of range float to
// integer casts follow what x86-64 does, which is what upstream's `static_cast` ends up with on the machine it is usually run on.

use std::collections::HashMap;
use std::sync::OnceLock;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::shader_fconvert::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::context::ShaderOcpMicroscalingTypesFeaturesExt;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RANDOM_SEED: u32 = 0xdead_beef;
const RANDOM_SOURCES_PER_TYPE: usize = 240;
const MAX_VECTOR_LENGTH: usize = 16;
const ARRAY_ALIGNMENT: usize = 16;
/// Effective length of a vector of size i.
const EFFECTIVE_LENGTH: [usize; MAX_VECTOR_LENGTH + 1] = [0, 1, 2, 4, 4, 8, 8, 8, 8, 16, 16, 16, 16, 16, 16, 16, 16];
/// Greatest common factor of the number of floats in a test.
const GCF_NUM_FLOATS: usize = 3 * MAX_VECTOR_LENGTH;
const HEADER_SIZE: usize = 16;

const HAS_SIGN: u32 = 1;
const SUPPORT_DENORM: u32 = 2;
const NO_INFINITY: u32 = 4;
const NO_NAN: u32 = 8;
const NO_ZERO: u32 = 16;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Rounding {
    ToEven,
    Downward,
    Upward,
}

/// The template parameters of `tcu::Float<StorageType, ExponentBits, MantissaBits, ExponentBias, Flags>`; `bytes` is `sizeof(StorageType)`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
struct Fmt {
    exp_bits: u32,
    man_bits: u32,
    bias: i32,
    bytes: usize,
    flags: u32,
}

const FLOAT16: Fmt = Fmt {
    exp_bits: 5,
    man_bits: 10,
    bias: 15,
    bytes: 2,
    flags: HAS_SIGN | SUPPORT_DENORM,
};
const FLOAT32: Fmt = Fmt {
    exp_bits: 8,
    man_bits: 23,
    bias: 127,
    bytes: 4,
    flags: HAS_SIGN | SUPPORT_DENORM,
};
const FLOAT64: Fmt = Fmt {
    exp_bits: 11,
    man_bits: 52,
    bias: 1023,
    bytes: 8,
    flags: HAS_SIGN | SUPPORT_DENORM,
};
const BRAIN_FLOAT16: Fmt = Fmt {
    exp_bits: 8,
    man_bits: 7,
    bias: 127,
    bytes: 2,
    flags: HAS_SIGN | SUPPORT_DENORM,
};
const FLOAT_E5M2: Fmt = Fmt {
    exp_bits: 5,
    man_bits: 2,
    bias: 15,
    bytes: 1,
    flags: HAS_SIGN | SUPPORT_DENORM,
};
const FLOAT_E4M3: Fmt = Fmt {
    exp_bits: 4,
    man_bits: 3,
    bias: 7,
    bytes: 1,
    flags: HAS_SIGN | SUPPORT_DENORM | NO_INFINITY,
};
const FLOAT_E2M1: Fmt = Fmt {
    exp_bits: 2,
    man_bits: 1,
    bias: 1,
    bytes: 1,
    flags: HAS_SIGN | SUPPORT_DENORM | NO_INFINITY | NO_NAN,
};
const FLOAT_E3M2: Fmt = Fmt {
    exp_bits: 3,
    man_bits: 2,
    bias: 3,
    bytes: 1,
    flags: HAS_SIGN | SUPPORT_DENORM | NO_INFINITY | NO_NAN,
};
const FLOAT_E2M3: Fmt = Fmt {
    exp_bits: 2,
    man_bits: 3,
    bias: 1,
    bytes: 1,
    flags: HAS_SIGN | SUPPORT_DENORM | NO_INFINITY | NO_NAN,
};
const FLOAT_UE8M0: Fmt = Fmt {
    exp_bits: 8,
    man_bits: 0,
    bias: 127,
    bytes: 1,
    flags: SUPPORT_DENORM | NO_INFINITY | NO_ZERO,
};

/// `tcu::Float<...>`: the bits of one value of the format.
#[derive(Clone, Copy, Debug)]
struct Fl {
    fmt: Fmt,
    bits: u64,
}

impl Fl {
    /// The constructor from the storage value: what does not fit `StorageType` is cut off, as the casts of upstream do.
    fn new(fmt: Fmt, bits: u64) -> Self {
        let mask = if fmt.bytes == 8 {
            u64::MAX
        } else {
            (1u64 << (8 * fmt.bytes)) - 1
        };
        Self { fmt, bits: bits & mask }
    }

    fn from_f64(value: f64) -> Self {
        Self::new(FLOAT64, value.to_bits())
    }

    fn has(&self, flag: u32) -> bool {
        self.fmt.flags & flag != 0
    }

    fn sign_bit(&self) -> u64 {
        if self.fmt.exp_bits + self.fmt.man_bits == 8 * self.fmt.bytes as u32 {
            0
        } else {
            (self.bits >> (self.fmt.exp_bits + self.fmt.man_bits)) & 1
        }
    }

    fn exponent_bits(&self) -> u64 {
        (self.bits >> self.fmt.man_bits) & ((1u64 << self.fmt.exp_bits) - 1)
    }

    fn mantissa_bits(&self) -> u64 {
        self.bits & ((1u64 << self.fmt.man_bits) - 1)
    }

    fn sign(&self) -> i32 {
        if self.sign_bit() != 0 { -1 } else { 1 }
    }

    fn exponent(&self) -> i32 {
        if self.is_denorm() {
            1 - self.fmt.bias
        } else {
            self.exponent_bits() as i32 - self.fmt.bias
        }
    }

    fn mantissa(&self) -> u64 {
        if self.is_zero() || self.is_denorm() {
            self.mantissa_bits()
        } else {
            self.mantissa_bits() | (1u64 << self.fmt.man_bits)
        }
    }

    fn is_inf(&self) -> bool {
        !self.has(NO_INFINITY) && self.exponent_bits() == (1u64 << self.fmt.exp_bits) - 1 && self.mantissa_bits() == 0
    }

    fn is_nan(&self) -> bool {
        if self.has(NO_NAN) {
            return false;
        }
        if !self.has(NO_INFINITY) {
            self.exponent_bits() == (1u64 << self.fmt.exp_bits) - 1 && self.mantissa_bits() != 0
        } else {
            let mask = (1u64 << (self.fmt.exp_bits + self.fmt.man_bits)) - 1;
            self.bits & mask == mask
        }
    }

    fn is_zero(&self) -> bool {
        if self.has(NO_ZERO) {
            return false;
        }
        self.exponent_bits() == 0 && self.mantissa_bits() == 0
    }

    fn is_denorm(&self) -> bool {
        self.exponent_bits() == 0 && self.mantissa_bits() != 0
    }

    fn zero(fmt: Fmt, sign: i32) -> Self {
        Self::new(fmt, u64::from(sign <= 0) << (fmt.exp_bits + fmt.man_bits))
    }

    fn inf(fmt: Fmt, sign: i32) -> Self {
        Self::new(
            fmt,
            (u64::from(sign <= 0) << (fmt.exp_bits + fmt.man_bits)) | (((1u64 << fmt.exp_bits) - 1) << fmt.man_bits),
        )
    }

    fn nan(fmt: Fmt) -> Self {
        Self::new(fmt, (1u64 << (fmt.exp_bits + fmt.man_bits)) - 1)
    }

    fn largest_normal(fmt: Fmt, sign: i32) -> Self {
        if fmt.flags & NO_INFINITY == 0 {
            Self::construct(fmt, sign, fmt.bias, (1u64 << (fmt.man_bits + 1)) - 1)
        } else if fmt.man_bits == 0 && fmt.flags & NO_NAN == 0 {
            Self::construct(fmt, sign, fmt.bias, 0)
        } else {
            Self::construct(fmt, sign, fmt.bias + 1, (1u64 << (fmt.man_bits + 1)) - 2)
        }
    }

    fn smallest_normal(fmt: Fmt, sign: i32) -> Self {
        Self::construct(fmt, sign, 1 - fmt.bias, 1u64 << fmt.man_bits)
    }

    /// `Float::construct(sign, exponent, mantissa)`: the mantissa carries its leading bit.
    fn construct(fmt: Fmt, sign: i32, exponent: i32, mantissa: u64) -> Self {
        let is_shorthand_zero = exponent == 0 && mantissa == 0;
        let is_denorm_or_zero = exponent == 1 - fmt.bias && (mantissa >> fmt.man_bits) == 0;
        let s = u64::from(sign < 0) << (fmt.exp_bits + fmt.man_bits);
        let exp = if is_shorthand_zero || is_denorm_or_zero {
            0
        } else {
            (exponent + fmt.bias) as u64
        };
        Self::new(
            fmt,
            s | (exp << fmt.man_bits) | (mantissa & ((1u64 << fmt.man_bits) - 1)),
        )
    }

    /// `Float::convert`
    fn convert(self, dst: Fmt, rd: Rounding) -> Self {
        if self.fmt == dst {
            return self;
        }
        let sign = self.sign();
        if dst.flags & HAS_SIGN == 0 && sign < 0 {
            return Self::zero(dst, 1);
        }
        let inf_val = if dst.flags & NO_INFINITY == 0 {
            Self::inf(dst, sign)
        } else {
            Self::nan(dst)
        };
        if self.is_inf() {
            return inf_val;
        }
        if self.is_nan() {
            return Self::nan(dst);
        }
        if self.is_zero() {
            return Self::zero(dst, sign);
        }

        let e_min = 1 - dst.bias;
        let e_max = ((1i32 << dst.exp_bits) - if dst.flags & NO_INFINITY == 0 { 2 } else { 1 }) - dst.bias;
        let s = self.sign_bit() << (dst.exp_bits + dst.man_bits);
        let mut e = self.exponent();
        let mut m = self.mantissa();
        let other_man = self.fmt.man_bits as i32;
        let man = dst.man_bits as i32;

        while m & (1u64 << other_man) == 0 {
            m <<= 1;
            e -= 1;
        }

        if e < e_min {
            if dst.flags & SUPPORT_DENORM != 0 && e_min - e - 1 <= man {
                let bit_diff = (other_man - man) + (e_min - e);
                if bit_diff < 0 {
                    return Self::new(dst, s | (m << (-bit_diff)));
                }
                let bd = bit_diff as u32;
                let last_bits = m & ((1u64 << bd) - 1);
                let half = if bd == 0 { u64::MAX >> 1 } else { (1u64 << (bd - 1)) - 1 };
                let bias = (m >> bd) & 1;
                return match rd {
                    Rounding::ToEven => Self::new(dst, s | (m.wrapping_add(half).wrapping_add(bias) >> bd)),
                    Rounding::Downward => {
                        let rounded = (m >> bd) + u64::from(last_bits != 0 && sign < 0);
                        Self::new(dst, s | rounded)
                    }
                    Rounding::Upward => {
                        let rounded = (m >> bd) + u64::from(last_bits != 0 && sign > 0);
                        Self::new(dst, s | rounded)
                    }
                };
            }
            return Self::zero(dst, sign);
        }

        m &= !(1u64 << other_man);

        if man < other_man {
            let bd = (other_man - man) as u32;
            let last_bits = m & ((1u64 << bd) - 1);
            let half = (1u64 << (bd - 1)) - 1;
            let bias = (m >> bd) & 1;
            m = match rd {
                Rounding::ToEven => (m + half + bias) >> bd,
                Rounding::Downward => (m >> bd) + u64::from(last_bits != 0 && sign < 0),
                Rounding::Upward => (m >> bd) + u64::from(last_bits != 0 && sign > 0),
            };
            if m & (1u64 << man) != 0 {
                m = 0;
                e += 1;
            }
        } else {
            m <<= man - other_man;
        }

        if e > e_max {
            return if (sign < 0 && rd == Rounding::Upward) || (sign > 0 && rd == Rounding::Downward) {
                Self::largest_normal(dst, sign)
            } else {
                inf_val
            };
        }

        Self::new(dst, s | (((e + dst.bias) as u64) << man) | m)
    }

    fn as_double(self) -> f64 {
        f64::from_bits(self.convert(FLOAT64, Rounding::ToEven).bits)
    }

    fn as_float(self) -> f32 {
        f32::from_bits(self.convert(FLOAT32, Rounding::ToEven).bits as u32)
    }
}

/// The float types of `bfloat16.constant`: `FloatTy(float)` and `FloatTy::asFloat()` on their storage bits.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum StorageFloat {
    Bf16,
    E5m2,
    E4m3,
}

impl StorageFloat {
    pub(super) fn bytes(self) -> usize {
        self.fmt().bytes
    }

    fn fmt(self) -> Fmt {
        match self {
            Self::Bf16 => BRAIN_FLOAT16,
            Self::E5m2 => FLOAT_E5M2,
            Self::E4m3 => FLOAT_E4M3,
        }
    }

    #[expect(
        clippy::wrong_self_convention,
        reason = "upstream's name for the conversion of a value to the type's bits"
    )]
    pub(super) fn from_f32(self, value: f32) -> u64 {
        Fl::new(FLOAT32, u64::from(value.to_bits()))
            .convert(self.fmt(), Rounding::ToEven)
            .bits
    }

    pub(super) fn to_f32(self, bits: u64) -> f32 {
        Fl::new(self.fmt(), bits).as_float()
    }
}

/// `context.getShaderFloat8FeaturesEXT().shaderFloat8`
pub(super) fn shader_float8_supported(context: &Context<'_>) -> bool {
    let mut float8 = vk::PhysicalDeviceShaderFloat8FeaturesEXT::default();
    if context.is_device_functionality_supported("VK_EXT_shader_float8") {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut float8);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    float8.shader_float8 != vk::FALSE
}

/// `DataType`, in upstream's order (the index travels in the header of the input buffer).
#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
enum DataType {
    F16 = 0,
    F32,
    F64,
    Bf16,
    E5m2,
    E4m3,
    E2m1,
    E3m2,
    E2m3,
    Ue8m0,
    MxInt8,
    I32,
    U32,
}

const DATA_TYPES: [DataType; 13] = [
    DataType::F16,
    DataType::F32,
    DataType::F64,
    DataType::Bf16,
    DataType::E5m2,
    DataType::E4m3,
    DataType::E2m1,
    DataType::E3m2,
    DataType::E2m3,
    DataType::Ue8m0,
    DataType::MxInt8,
    DataType::I32,
    DataType::U32,
];

impl DataType {
    fn fmt(self) -> Option<Fmt> {
        Some(match self {
            Self::F16 => FLOAT16,
            Self::F32 => FLOAT32,
            Self::F64 => FLOAT64,
            Self::Bf16 => BRAIN_FLOAT16,
            Self::E5m2 => FLOAT_E5M2,
            Self::E4m3 => FLOAT_E4M3,
            Self::E2m1 => FLOAT_E2M1,
            Self::E3m2 => FLOAT_E3M2,
            Self::E2m3 => FLOAT_E2M3,
            Self::Ue8m0 => FLOAT_UE8M0,
            Self::MxInt8 | Self::I32 | Self::U32 => return None,
        })
    }

    /// `getElementSize<T>`
    fn element_size(self) -> usize {
        match self {
            Self::I32 | Self::U32 => 4,
            Self::MxInt8 => 1,
            other => other.fmt().map_or(1, |fmt| fmt.bytes),
        }
    }

    fn name(self) -> &'static str {
        match self {
            Self::F16 => "f16",
            Self::F32 => "f32",
            Self::F64 => "f64",
            Self::Bf16 => "bf16",
            Self::E5m2 => "fe5m2",
            Self::E4m3 => "fe4m3",
            Self::E2m1 => "fe2m1",
            Self::E3m2 => "fe3m2",
            Self::E2m3 => "fe2m3",
            Self::Ue8m0 => "fue8m0",
            Self::MxInt8 => "fmxint8",
            Self::I32 => "i32",
            Self::U32 => "u32",
        }
    }
}

/// One element: a `tcu::Float<...>`, a `tcu::FloatMXINT8` (its bits) or an integer.
#[derive(Clone, Copy, Debug)]
enum Value {
    Float(Fl),
    MxInt8(u8),
    I32(i32),
    U32(u32),
}

impl Value {
    fn storage_bits(self) -> u64 {
        match self {
            Self::Float(f) => f.bits,
            Self::MxInt8(b) => u64::from(b),
            Self::I32(v) => u64::from(v as u32),
            Self::U32(v) => u64::from(v),
        }
    }

    fn from_storage(dt: DataType, bits: u64) -> Self {
        match dt {
            DataType::MxInt8 => Self::MxInt8(bits as u8),
            DataType::I32 => Self::I32(bits as u32 as i32),
            DataType::U32 => Self::U32(bits as u32),
            other => Self::Float(Fl::new(other.fmt().expect("a float type"), bits)),
        }
    }
}

/// `getRandomNormal<T>`
fn get_random_normal(dt: DataType, rnd: &mut Random) -> Value {
    match dt {
        DataType::MxInt8 => Value::MxInt8((rnd.get_uint32() & 0xff) as u8),
        DataType::I32 => Value::I32(rnd.get_uint32() as i32),
        DataType::U32 => Value::U32(rnd.get_uint32()),
        other => {
            let fmt = other.fmt().expect("a float type");
            let leading_mantissa_bit = 1u64 << fmt.man_bits;
            let sign_bit = rnd.get_int(0, 1);
            let exponent = rnd.get_int(1 - fmt.bias, fmt.bias + 1);
            let mantissa = rnd.get_uint64() & (leading_mantissa_bit - 1);
            let sign = if sign_bit == 1 { 1 } else { -1 };
            Value::Float(Fl::construct(fmt, sign, exponent, leading_mantissa_bit | mantissa))
        }
    }
}

/// `interestingSamples<T>`. `FloatMXINT8::largestNormal/smallestNormal` take any non-zero sign for the negative one, so both signs give the same value.
fn interesting_samples(dt: DataType) -> Vec<Value> {
    match dt {
        DataType::I32 => [0, 0, i32::MAX, i32::MAX, i32::MIN, i32::MIN].map(Value::I32).to_vec(),
        DataType::U32 => [0, 0, u32::MAX, u32::MAX, 0, 0].map(Value::U32).to_vec(),
        DataType::MxInt8 => [0x00, 0x00, 0x81, 0x81, 0xff, 0xff].map(Value::MxInt8).to_vec(),
        other => {
            let fmt = other.fmt().expect("a float type");
            if fmt.flags & HAS_SIGN != 0 {
                vec![
                    Value::Float(Fl::zero(fmt, -1)),
                    Value::Float(Fl::zero(fmt, 1)),
                    Value::Float(Fl::largest_normal(fmt, -1)),
                    Value::Float(Fl::largest_normal(fmt, 1)),
                    Value::Float(Fl::smallest_normal(fmt, -1)),
                    Value::Float(Fl::smallest_normal(fmt, 1)),
                ]
            } else {
                vec![
                    Value::Float(Fl::zero(fmt, 1)),
                    Value::Float(Fl::largest_normal(fmt, 1)),
                    Value::Float(Fl::smallest_normal(fmt, 1)),
                ]
            }
        }
    }
}

/// `getExhaustive<T>`: every pattern of a type of at most 16 bits.
fn get_exhaustive(dt: DataType) -> Vec<Value> {
    let storage_bits = 8 * dt.element_size() as u32;
    if storage_bits > 16 {
        return Vec::new();
    }
    (0..(1u64 << storage_bits))
        .map(|i| Value::from_storage(dt, i))
        .collect()
}

fn convert_vector(values: &[Value], to: DataType) -> Vec<Value> {
    let fmt = to.fmt().expect("a float type");
    values
        .iter()
        .map(|value| match value {
            Value::Float(f) => Value::Float(f.convert(fmt, Rounding::ToEven)),
            other => *other,
        })
        .collect()
}

/// `InputGenerator`: the random normals of a type are drawn the first time they are asked for.
struct InputGenerator {
    rnd: Random,
    normals: HashMap<DataType, Vec<Value>>,
}

impl InputGenerator {
    /// `getRandomNormals<T>`
    fn random_normals(&mut self, dt: DataType) -> Vec<Value> {
        if !self.normals.contains_key(&dt) {
            let values = (0..RANDOM_SOURCES_PER_TYPE)
                .map(|_| get_random_normal(dt, &mut self.rnd))
                .collect();
            self.normals.insert(dt, values);
        }
        self.normals[&dt].clone()
    }

    /// `getOtherNormals<T>`
    fn other_normals(&mut self, dt: DataType) -> Vec<Value> {
        let sources: &[DataType] = match dt {
            DataType::F16 | DataType::Bf16 => &[DataType::E5m2, DataType::E4m3],
            DataType::F32 => &[DataType::F16, DataType::Bf16, DataType::E5m2, DataType::E4m3],
            DataType::F64 => &[
                DataType::F16,
                DataType::F32,
                DataType::Bf16,
                DataType::E5m2,
                DataType::E4m3,
            ],
            _ => &[],
        };
        let mut result = Vec::new();
        for &source in sources {
            let normals = self.random_normals(source);
            result.extend(convert_vector(&normals, dt));
        }
        result
    }

    /// `getInputValues<T>`
    fn input_values(&mut self, dt: DataType) -> Vec<Value> {
        let interesting = interesting_samples(dt);
        let normals = self.random_normals(dt);
        let other_normals = self.other_normals(dt);
        let exhaustive = get_exhaustive(dt);

        let num_values = interesting.len() + normals.len() + other_normals.len() + exhaustive.len();
        let extra_values = num_values % GCF_NUM_FLOATS;
        let needed = if extra_values == 0 {
            0
        } else {
            GCF_NUM_FLOATS - extra_values
        };
        let extra: Vec<Value> = (0..needed).map(|_| *self.rnd.choose(&interesting)).collect();

        let mut values = Vec::with_capacity(num_values + needed);
        values.extend(interesting);
        values.extend(normals);
        values.extend(other_normals);
        values.extend(exhaustive);
        values.extend(extra);
        self.rnd.shuffle(&mut values);
        values
    }
}

/// `InputGenerator::getInstance().getValues<T>()`: the values of every type, built in the order of upstream's member initialisers.
fn input_values(dt: DataType) -> &'static [Value] {
    static VALUES: OnceLock<HashMap<DataType, Vec<Value>>> = OnceLock::new();
    VALUES
        .get_or_init(|| {
            let mut generator = InputGenerator {
                rnd: Random::new(RANDOM_SEED),
                normals: HashMap::new(),
            };
            DATA_TYPES.iter().map(|&ty| (ty, generator.input_values(ty))).collect()
        })
        .get(&dt)
        .map(Vec::as_slice)
        .unwrap_or(&[])
}

/// The cast `static_cast<int32_t>(double)` compiles to on x86-64.
fn host_cast_i32(d: f64) -> i32 {
    if d.is_nan() || d >= 2147483648.0 || d <= -2147483649.0 {
        i32::MIN
    } else {
        d as i32
    }
}

/// The cast `static_cast<uint32_t>(double)` compiles to on x86-64: a 64-bit conversion, of which the low half is kept.
fn host_cast_u32(d: f64) -> u32 {
    let wide = if d.is_nan() || d >= 9.223_372_036_854_776e18 || d < -9.223_372_036_854_776e18 {
        i64::MIN
    } else {
        d as i64
    };
    wide as u32
}

/// `validConversion(orig, result, sat)` for one element.
#[expect(clippy::if_same_then_else, reason = "upstream spells out every accepted case")]
fn valid_conversion(orig: Value, result: Value, sat: bool) -> bool {
    let orig = match orig {
        Value::MxInt8(bits) => {
            if bits == 0x80 {
                return true;
            }
            let v = i32::from(bits as i8).max(-127);
            Value::Float(Fl::from_f64(f64::from(v) / 64.0).convert(FLOAT32, Rounding::ToEven))
        }
        other => other,
    };
    let orig_is_int = matches!(orig, Value::I32(_) | Value::U32(_));
    let result_is_int = matches!(result, Value::I32(_) | Value::U32(_));

    if result_is_int
        && !orig_is_int
        && let Value::Float(f) = orig
        && f.is_nan()
    {
        return true;
    }

    let accepted: Vec<Value> = match (orig, result) {
        (Value::I32(_) | Value::U32(_), Value::Float(r)) => {
            let d = match orig {
                Value::I32(v) => f64::from(v),
                Value::U32(v) => f64::from(v),
                _ => 0.0,
            };
            let exact = Fl::from_f64(d);
            vec![
                Value::Float(exact.convert(r.fmt, Rounding::Downward)),
                Value::Float(exact.convert(r.fmt, Rounding::Upward)),
            ]
        }
        (Value::Float(f), Value::I32(_)) => {
            let d = f.as_double();
            let converted = Value::I32(host_cast_i32(d));
            if d < f64::from(i32::MIN) {
                vec![converted, Value::I32(i32::MIN)]
            } else if d > f64::from(i32::MAX) {
                vec![converted, Value::I32(i32::MAX)]
            } else {
                vec![converted]
            }
        }
        (Value::Float(f), Value::U32(_)) => {
            let d = f.as_double();
            let converted = Value::U32(host_cast_u32(d));
            if d < f64::from(u32::MIN) {
                vec![converted, Value::U32(u32::MIN)]
            } else if d > f64::from(u32::MAX) {
                vec![converted, Value::U32(u32::MAX)]
            } else {
                vec![converted]
            }
        }
        (Value::Float(f), Value::Float(r)) => vec![
            Value::Float(f.convert(r.fmt, Rounding::Downward)),
            Value::Float(f.convert(r.fmt, Rounding::Upward)),
        ],
        _ => Vec::new(),
    };

    let mut valid = false;
    for valid_result in accepted {
        match (valid_result, result) {
            (Value::I32(a), Value::I32(b)) => {
                if a == b {
                    valid = true;
                }
            }
            (Value::U32(a), Value::U32(b)) => {
                if a == b {
                    valid = true;
                }
            }
            (Value::Float(valid_float), Value::Float(res)) => {
                if valid_float.is_nan() && res.is_nan() {
                    valid = true;
                } else if !sat && valid_float.is_inf() && res.is_inf() {
                    valid = true;
                } else if valid_float.is_zero() && res.is_zero() {
                    valid = true;
                } else if valid_float.is_denorm() && res.is_zero() {
                    valid = true;
                } else if valid_float.bits == res.bits && !(sat && res.is_inf()) {
                    valid = true;
                }

                if let Value::Float(o) = orig {
                    if o.is_denorm() && res.is_zero() {
                        valid = true;
                    } else if sat
                        && o.as_float().abs() > Fl::largest_normal(res.fmt, 1).as_float()
                        && o.sign() == res.sign()
                        && res.as_float() == Fl::largest_normal(res.fmt, o.sign()).as_float()
                    {
                        valid = true;
                    }
                }
            }
            _ => {}
        }
    }
    valid
}

/// `BufferSizeInfo`
struct BufferSizeInfo {
    num_values: usize,
    total_vectors: usize,
    vector_stride_bytes: usize,
    memory_size_bytes: usize,
}

impl BufferSizeInfo {
    fn calculate(element_size: usize, num_values: usize, vector_length: usize) -> Self {
        let total_vectors = num_values / vector_length;
        let vector_size = element_size * EFFECTIVE_LENGTH[vector_length];
        let extra_bytes = vector_size % ARRAY_ALIGNMENT;
        let vector_stride_bytes = vector_size
            + if extra_bytes == 0 {
                0
            } else {
                ARRAY_ALIGNMENT - extra_bytes
            };
        Self {
            num_values,
            total_vectors,
            vector_stride_bytes,
            memory_size_bytes: vector_stride_bytes * total_vectors,
        }
    }
}

/// `packData`: the values as an array of vectors of `vector_length` elements, std140.
fn pack_data(values: &[Value], element_size: usize, vector_length: usize) -> Vec<u8> {
    let info = BufferSizeInfo::calculate(element_size, values.len(), vector_length);
    let mut memory = vec![0u8; info.memory_size_bytes];
    for i in 0..info.total_vectors {
        for j in 0..vector_length {
            let offset = info.vector_stride_bytes * i + j * element_size;
            let bits = values[i * vector_length + j].storage_bits().to_le_bytes();
            memory[offset..offset + element_size].copy_from_slice(&bits[..element_size]);
        }
    }
    memory
}

/// `unpackData`
fn unpack_data(dt: DataType, memory: &[u8], vector_length: usize) -> Vec<Value> {
    let element_size = dt.element_size();
    let info = BufferSizeInfo::calculate(element_size, vector_length, vector_length);
    let mut values = Vec::new();
    for block in memory.chunks_exact(info.vector_stride_bytes) {
        for j in 0..vector_length {
            let mut bytes = [0u8; 8];
            bytes[..element_size].copy_from_slice(&block[j * element_size..(j + 1) * element_size]);
            values.push(Value::from_storage(dt, u64::from_le_bytes(bytes)));
        }
    }
    values
}

#[derive(Clone, Copy, Debug)]
struct TestParams {
    from: DataType,
    to: DataType,
    vector_length: usize,
    saturated_convert: bool,
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    bitcast_extract: bool,
}

impl TestParams {
    fn uses_bfloat16(&self) -> bool {
        self.from == DataType::Bf16 || self.to == DataType::Bf16
    }

    fn uses_fp8(&self) -> bool {
        matches!(self.from, DataType::E5m2 | DataType::E4m3) || matches!(self.to, DataType::E5m2 | DataType::E4m3)
    }
}

fn data_type_at(index: u32) -> DataType {
    DATA_TYPES[index as usize]
}

/// `verifyConversion`: the parameters are in the last `HEADER_SIZE` bytes of the input, the values are the ones the generator made.
fn verify(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let header = &inputs[0][inputs[0].len() - HEADER_SIZE..];
    let word = |i: usize| u32::from_le_bytes([header[i * 4], header[i * 4 + 1], header[i * 4 + 2], header[i * 4 + 3]]);
    let from = data_type_at(word(0));
    let to = data_type_at(word(1));
    let vector_length = word(2) as usize;
    let sat = word(3) != 0;

    let input = input_values(from);
    let output = unpack_data(to, &outputs[0], vector_length);
    if output.len() != input.len() {
        return false;
    }
    input
        .iter()
        .zip(&output)
        .all(|(&orig, &result)| valid_conversion(orig, result, sat))
}

fn build_spec(params: &TestParams) -> ComputeShaderSpec {
    let input = input_values(params.from);
    let input_info = BufferSizeInfo::calculate(params.from.element_size(), input.len(), params.vector_length);
    let output_info = BufferSizeInfo::calculate(params.to.element_size(), input_info.num_values, params.vector_length);

    let mut input_memory = pack_data(input, params.from.element_size(), params.vector_length);
    for word in [
        params.from as u32,
        params.to as u32,
        params.vector_length as u32,
        u32::from(params.saturated_convert),
    ] {
        input_memory.extend(word.to_le_bytes());
    }

    let mut spec = ComputeShaderSpec {
        num_work_groups: [input_info.total_vectors as u32, 1, 1],
        verify_io: Some(verify),
        ..Default::default()
    };
    spec.inputs.push(input_memory);
    spec.outputs.push(vec![0u8; output_info.memory_size_bytes]);
    spec
}

/// The features and extensions the shader needs that the assembly case can check.
fn feature_spec(params: &TestParams) -> ComputeShaderSpec {
    let mut spec = ComputeShaderSpec::default();
    if params.from == DataType::F64 || params.to == DataType::F64 {
        spec.features.push(RequiredFeature::ShaderFloat64);
    }
    if params.from == DataType::F16 || params.to == DataType::F16 {
        spec.features.extend([
            RequiredFeature::ShaderFloat16,
            RequiredFeature::StorageBuffer16BitAccess,
            RequiredFeature::UniformAndStorageBuffer16BitAccess,
        ]);
    }
    if params.uses_bfloat16() {
        spec.features.push(RequiredFeature::BFloat16Type);
    }
    if params.vector_length > 4 {
        spec.features.push(RequiredFeature::LongVector);
    }
    spec
}

fn not_supported(message: &str) -> Result<(), TestError> {
    Err(TestError::NotSupported(message.to_string()))
}

struct FConvertCase {
    name: String,
    params: TestParams,
}

impl TestCase for FConvertCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `FConvertTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if ALL_SHARED_PROGRAM.iter().all(|p| p.name != self.name) {
            return Err(TestError::NotSupported(
                "shader not generated: glslang lacks the sub-byte float extension".to_string(),
            ));
        }
        let params = &self.params;
        let features_case = SpvAsmComputeShaderCase {
            name: self.name.clone(),
            spec: feature_spec(params),
            programs: BinaryCollection::new(&[]),
        };
        features_case.check_support(context)?;

        if params.uses_fp8() {
            let mut float8 = vk::PhysicalDeviceShaderFloat8FeaturesEXT::default();
            if context.is_device_functionality_supported("VK_EXT_shader_float8") {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut float8);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if float8.shader_float8 == vk::FALSE {
                return not_supported("VK_EXT_shader_float8 not supported by device");
            }
        }

        if matches!(
            params.from,
            DataType::E2m1 | DataType::E3m2 | DataType::E2m3 | DataType::Ue8m0 | DataType::MxInt8
        ) {
            let mut ocp = ShaderOcpMicroscalingTypesFeaturesExt::default();
            if context.is_device_functionality_supported("VK_EXT_shader_ocp_microscaling_types") {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut ocp);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            match params.from {
                DataType::E2m1 if ocp.shader_float4 == vk::FALSE => {
                    return not_supported("shaderFloat4 not supported by device");
                }
                DataType::E3m2 | DataType::E2m3 if ocp.shader_float6 == vk::FALSE => {
                    return not_supported("shaderFloat6 not supported by device");
                }
                DataType::Ue8m0 if ocp.shader_float8_unsigned_e8m0 == vk::FALSE => {
                    return not_supported("shaderFloat8UnsignedE8M0 not supported by device");
                }
                DataType::MxInt8 if ocp.shader_mx_int8 == vk::FALSE => {
                    return not_supported("shaderMXInt8 not supported by device");
                }
                _ => {}
            }
        }

        // VUID-vkCmdDispatch-groupCountX-00386
        let total_vectors = input_values(params.from).len() / params.vector_length;
        let limit = context.get_device_properties().limits.max_compute_work_group_count[0];
        if total_vectors as u64 > u64::from(limit) {
            return Err(TestError::NotSupported(format!(
                "Test requires {total_vectors} compute work groups, but device limit is {limit}"
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == self.name)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FConvertInstance {
            context,
            params: self.params,
            programs: self.programs(),
        })
    }
}

struct FConvertInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    programs: BinaryCollection,
}

impl TestInstance for FConvertInstance<'_> {
    /// `FConvertTestInstance::iterate`; the buffers are built here and not with the case so that the 750 cases do not hold their input between them.
    fn iterate(&mut self) -> TestOutcome {
        let case = SpvAsmComputeShaderCase {
            name: String::new(),
            spec: build_spec(&self.params),
            programs: self.programs,
        };
        case.create_instance(self.context).iterate()
    }
}

fn add_case(group: &mut TestCaseGroup, name: String, params: TestParams) {
    group.add_child(Box::new(FConvertCase { name, params }) as Box<dyn TestCase>);
}

/// `createPrecisionFconvertGroup`
pub fn create_precision_fconvert_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("precision_fconvert");

    let float_types = [
        DataType::E5m2,
        DataType::E4m3,
        DataType::E2m1,
        DataType::E3m2,
        DataType::E2m3,
        DataType::Ue8m0,
        DataType::MxInt8,
        DataType::Bf16,
        DataType::F16,
        DataType::F32,
        DataType::F64,
    ];
    let vector_lengths = [1usize, 2, 3, 4, 8, 16];
    let is_fp8 = |t: DataType| matches!(t, DataType::E5m2 | DataType::E4m3);
    let is_sub_byte = |t: DataType| {
        matches!(
            t,
            DataType::E2m1 | DataType::E3m2 | DataType::E2m3 | DataType::Ue8m0 | DataType::MxInt8
        )
    };

    for &from in &float_types {
        for &to in &float_types {
            for &k in &vector_lengths {
                for sat in [false, true] {
                    for bitcast_extract in [false, true] {
                        if from == to {
                            continue;
                        }
                        if bitcast_extract && !matches!(from, DataType::E2m1 | DataType::E3m2 | DataType::E2m3) {
                            continue;
                        }
                        if sat && (!is_fp8(to) || is_fp8(from)) {
                            continue;
                        }
                        if is_sub_byte(to) {
                            continue;
                        }
                        let name = format!(
                            "{}_to_{}_size_{}{}{}",
                            from.name(),
                            to.name(),
                            k,
                            if sat { "_sat" } else { "" },
                            if bitcast_extract { "_bitcastextract" } else { "" }
                        );
                        let params = TestParams {
                            from,
                            to,
                            vector_length: k,
                            saturated_convert: sat,
                            bitcast_extract,
                        };
                        add_case(&mut group, name, params);
                    }
                }
            }
        }
    }

    for &f in &float_types {
        if is_sub_byte(f) {
            continue;
        }
        for i in [DataType::I32, DataType::U32] {
            for &k in &vector_lengths {
                let size_name = format!("_size_{k}");
                let to_int = TestParams {
                    from: f,
                    to: i,
                    vector_length: k,
                    saturated_convert: false,
                    bitcast_extract: false,
                };
                add_case(&mut group, format!("{}_to_{}{}", f.name(), i.name(), size_name), to_int);
                let from_int = TestParams {
                    from: i,
                    to: f,
                    vector_length: k,
                    saturated_convert: false,
                    bitcast_extract: false,
                };
                add_case(
                    &mut group,
                    format!("{}_to_{}{}", i.name(), f.name(), size_name),
                    from_int,
                );
            }
        }
    }
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The array sizes `scripts/gen_fconvert_manifest.py` writes into the shaders.
    #[test]
    fn input_counts_match_the_generated_shaders() {
        let expected = [
            (DataType::F16, 66288),
            (DataType::F32, 1248),
            (DataType::F64, 1488),
            (DataType::Bf16, 66288),
            (DataType::E5m2, 528),
            (DataType::E4m3, 528),
            (DataType::E2m1, 528),
            (DataType::E3m2, 528),
            (DataType::E2m3, 528),
            (DataType::Ue8m0, 528),
            (DataType::MxInt8, 528),
            (DataType::I32, 288),
            (DataType::U32, 288),
        ];
        for (dt, count) in expected {
            assert_eq!(input_values(dt).len(), count, "{dt:?}");
        }
    }

    #[test]
    fn e4m3_largest_normal_is_the_upstream_value() {
        assert_eq!(Fl::largest_normal(FLOAT_E4M3, 1).bits, 0x7e);
        assert_eq!(
            Fl::new(FLOAT16, 0x3c00).convert(FLOAT32, Rounding::ToEven).bits,
            0x3f80_0000
        );
    }
}
