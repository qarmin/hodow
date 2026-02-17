use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_xor_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_xor_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 1.0, 1.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_xor_ps(
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                    _mm_set_ps(
                        get_random_float32_array::<4>()[0],
                        get_random_float32_array::<4>()[1],
                        get_random_float32_array::<4>()[2],
                        get_random_float32_array::<4>()[3],
                    ),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_broadcast_i32x2() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(1, 2, 3, 4);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_broadcast_i32x2() -> Result<(), String> {
    test_mm_broadcast_i32x2()
}
pub(super) fn test_mm_maskz_broadcast_i32x2() -> Result<(), String> {
    test_mm_broadcast_i32x2()
}

pub(super) fn test_mm_cvtepi64_pd() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(2, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[2i64, 1i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_pd() -> Result<(), String> {
    test_mm_cvtepi64_pd()
}
pub(super) fn test_mm_maskz_cvtepi64_pd() -> Result<(), String> {
    test_mm_cvtepi64_pd()
}

pub(super) fn test_mm_cvtepi64_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(7, 3);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[7i64, 3i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_ps() -> Result<(), String> {
    test_mm_cvtepi64_ps()
}
pub(super) fn test_mm_maskz_cvtepi64_ps() -> Result<(), String> {
    test_mm_cvtepi64_ps()
}

pub(super) fn test_mm_cvtepu64_pd() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(9, 8);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[9i64, 8i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu64_pd() -> Result<(), String> {
    test_mm_cvtepu64_pd()
}
pub(super) fn test_mm_maskz_cvtepu64_pd() -> Result<(), String> {
    test_mm_cvtepu64_pd()
}

pub(super) fn test_mm_cvtepu64_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(10, 11);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[10i64, 11i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu64_ps() -> Result<(), String> {
    test_mm_cvtepu64_ps()
}
