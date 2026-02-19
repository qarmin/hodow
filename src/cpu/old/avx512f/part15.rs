use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 21, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result_i = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[10, 21, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result_i = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[10, 21, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtpd_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result_i = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[10, 21, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi8_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepi8_epi32(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi8_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi8_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepi8_epi32(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi8_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi8_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepi8_epi64(a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi8_epi64(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi8_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepi8_epi64(a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi8_epi64(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepu8_epi32(a);
        let result_i: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        let result_u: [u32; 4] = [result_i[0] as u32, result_i[1] as u32, result_i[2] as u32, result_i[3] as u32];
        check_array_equality(&result_u, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepu8_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu8_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepu8_epi32(a);
        let result_i: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        let result_u: [u32; 4] = [result_i[0] as u32, result_i[1] as u32, result_i[2] as u32, result_i[3] as u32];
        check_array_equality(&result_u, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepu8_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepu8_epi64(a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepu8_epi64(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu8_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_cvtepu8_epi64(a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepu8_epi64(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let r = _mm_cvtepi16_epi32(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi16_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi16_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let r = _mm_cvtepi16_epi32(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi16_epi32(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let r = _mm_cvtepi16_epi64(a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi16_epi64(a_r);
            }
        }
    }
    Ok(())
}
