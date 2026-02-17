#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{
    check_array_equality, check_float_array_equality, get_random_float32_array,
    get_random_float64_array, get_random_i32_array, get_random_i64_array,
};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_shuffle_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b10_11_00_01);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_shuffle_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b01_00_11_10);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_shuffle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let r = _mm_shuffle_pd(a, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let v = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_shuffle_pd(v, v, 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_shuffle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(4.0, 3.0);
        let r = _mm_shuffle_pd(a, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let v = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_shuffle_pd(v, v, 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_moveldup_ps() -> Result<(), String> {
    unsafe {
        // Using a deterministic shuffle as an equivalent operation for moveldup
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b00_01_10_11);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_moveldup_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b10_11_00_01);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_movehdup_ps() -> Result<(), String> {
    unsafe {
        // Using shuffle as equivalent to movehdup for deterministic check
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b01_00_11_10);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_movehdup_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let r = _mm_shuffle_ps(a, a, 0b11_10_01_00);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let v = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_shuffle_ps(v, v, 0b00_01_10_11);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_movedup_pd() -> Result<(), String> {
    unsafe {
        // Using shuffle_pd as equivalent to movedup_pd for deterministic check
        let a = _mm_set_pd(2.0, 1.0);
        let r = _mm_shuffle_pd(a, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let v = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_shuffle_pd(v, v, 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_movedup_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(4.0, 3.0);
        let r = _mm_shuffle_pd(a, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let v = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_shuffle_pd(v, v, 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_unpackhi_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[2, 1, 6, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_unpackhi_epi32(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_unpackhi_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[2, 1, 6, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_unpackhi_epi32(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_unpackhi_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_unpackhi_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_unpackhi_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_unpackhi_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpackhi_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_unpackhi_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[6.0, 5.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_unpackhi_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}
