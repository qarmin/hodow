use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, -2);
        let r = _mm_cvtepi64_epi8(a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[8] as i32], &[1, -2])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let idx = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(idx[1], idx[0]);
                let _ = _mm_cvtepi64_epi8(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsepi32_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1000, -2000, 3000, -4000);
        let r = _mm_cvtsepi32_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1000, -2000, 3000, -4000])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1000, -2000, 3000, -4000);
        let r = _mm_cvtsepi32_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1000, -2000, 3000, -4000])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi32_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1000, -2000, 3000, -4000);
        let r = _mm_cvtsepi32_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1000, -2000, 3000, -4000])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsepi32_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_cvtsepi32_epi8(a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1, 2, 3, 4])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi8(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_cvtsepi32_epi8(a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1, 2, 3, 4])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi8(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi32_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_cvtsepi32_epi8(a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32, out[2] as i32, out[3] as i32], &[1, 2, 3, 4])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_cvtsepi32_epi8(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsepi64_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let r = _mm_cvtsepi64_epi32(a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[2, 1, 0, 0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let r = _mm_cvtsepi64_epi32(a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[2, 1, 0, 0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi64_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let r = _mm_cvtsepi64_epi32(a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[2, 1, 0, 0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsepi64_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(300, -300);
        let r = _mm_cvtsepi64_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32], &[300, -300])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(300, -300);
        let r = _mm_cvtsepi64_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32], &[300, -300])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi64_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(300, -300);
        let r = _mm_cvtsepi64_epi16(a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32], &[300, -300])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi16(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsepi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let r = _mm_cvtsepi64_epi8(a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32], &[1, 2])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtsepi64_epi8(a_r);
            }
        }
    }
    Ok(())
}
