#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
pub mod x86;

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
pub mod arm;

use std::fmt::Debug;

use rand::random;

/// 64-byte aligned wrapper for pointer-backed test buffers. Aligned/streaming SIMD
/// intrinsics (e.g. `_mm512_load_ps`, `_mm_stream_ps`) fault on under-aligned memory;
/// a plain `[f32; N]` only guarantees the element's alignment. Aligning to 64 bytes
/// satisfies every SIMD width up to AVX-512.
#[repr(C, align(64))]
pub struct Aligned64<T>(pub T);

pub trait FloatLike: PartialEq + Debug + std::ops::Sub<Output = Self> + PartialOrd + Copy {
    fn is_infinite(self) -> bool;
    fn is_nan(self) -> bool;
    fn abs(self) -> Self;
    fn from_f64(f: f64) -> Self;
}

impl FloatLike for f32 {
    fn is_infinite(self) -> bool {
        f32::is_infinite(self)
    }
    fn is_nan(self) -> bool {
        f32::is_nan(self)
    }
    fn abs(self) -> Self {
        f32::abs(self)
    }
    fn from_f64(f: f64) -> Self {
        f as f32
    }
}

impl FloatLike for f64 {
    fn is_infinite(self) -> bool {
        f64::is_infinite(self)
    }
    fn is_nan(self) -> bool {
        f64::is_nan(self)
    }
    fn abs(self) -> Self {
        f64::abs(self)
    }
    fn from_f64(f: f64) -> Self {
        f
    }
}

pub fn check_float_array_equality<T: FloatLike + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
    if a == b {
        return Ok(());
    }
    if a.len() != b.len() {
        return Err(format!("Got {a:?}, expected {b:?} (Arrays have different lengths: {} and {})", a.len(), b.len()));
    }

    let eps = T::from_f64(0.001);

    for i in 0..a.len() {
        if a[i].is_nan() != b[i].is_nan() {
            return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
        } else if a[i].is_infinite() != b[i].is_infinite() {
            return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
        } else if !a[i].is_nan() && (a[i] - b[i]).abs() > eps {
            return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
        }
    }

    Ok(())
}

pub fn check_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
    if a != b {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}

#[allow(dead_code)]
pub const DEFAULT_FLOAT_DIFF: f32 = 0.001;

#[allow(dead_code)]
pub fn check_float_equality<T: FloatLike + Debug>(a: T, b: T) -> Result<(), String> {
    if a == b {
        return Ok(());
    }

    let eps = T::from_f64(0.001);

    if a.is_nan() != b.is_nan() {
        return Err(format!("Got {a:?}, expected {b:?} (One is NaN, other is not)"));
    } else if a.is_infinite() != b.is_infinite() {
        return Err(format!("Got {a:?}, expected {b:?} (One is infinite, other is not)"));
    } else if !a.is_nan() && (a - b).abs() > eps {
        return Err(format!("Got {a:?}, expected {b:?} (Difference is too big)"));
    }

    Ok(())
}

pub fn check_int_equality<T: PartialEq + Debug>(a: T, b: T) -> Result<(), String> {
    if a != b {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}

#[allow(unused)]
pub fn check_int_equality_with_error(a: i32, b: i32, error: i32) -> Result<(), String> {
    if (a != b) && ((a > b && a - error > b) || (a < b && a + error < b)) {
        return Err(format!("Got {a:?}, expected {b:?}"));
    }

    Ok(())
}

pub fn get_random_float() -> f32 {
    match random::<u8>() % 12 {
        0 => f32::INFINITY,
        1 => f32::NEG_INFINITY,
        2 => f32::NAN,
        3..8 => random::<f32>() * 10000000.0,
        _ => random::<f32>() * 100000.0,
    }
}

pub fn get_random_float64() -> f64 {
    match random::<u8>() % 12 {
        0 => f64::INFINITY,
        1 => f64::NEG_INFINITY,
        2 => f64::NAN,
        3..8 => random::<f64>() * 10000000.0,
        _ => random::<f64>() * 100000.0,
    }
}

pub fn get_random_float32_array<const N: usize>() -> [f32; N] {
    let mut arr = [0.0; N];
    for item in arr.iter_mut() {
        *item = get_random_float();
    }
    arr
}

pub fn get_random_float64_array<const N: usize>() -> [f64; N] {
    let mut arr = [0.0; N];
    for item in arr.iter_mut() {
        *item = get_random_float64();
    }
    arr
}

pub fn get_random_i32_array<const N: usize>() -> [i32; N] {
    let mut arr = [0; N];
    for item in arr.iter_mut() {
        *item = random::<i32>();
    }
    arr
}

pub fn get_random_i64_array<const N: usize>() -> [i64; N] {
    let mut arr = [0; N];
    for item in arr.iter_mut() {
        *item = random::<i64>();
    }
    arr
}
