#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepi16_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 4, 3, 2, 1);
        // use full mask to behave like unmasked
        let r = _mm_maskz_cvtepi16_epi64(0xF, a);
        let out: [i64; 4] = std::mem::transmute::<__m256i, [i64; 4]>(r);
        check_array_equality(&out, &[1i64, 2i64, 3i64, 4i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepi16_epi64(0xF, _mm_set1_epi16(rnd[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu16_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 4, 3, 2, 1);
        let src = _mm_setzero_si128();
        let r = _mm_mask_cvtepu16_epi32(src, 0xF, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepu16_epi32(_mm_setzero_si128(), 0xF, _mm_set1_epi16(rnd[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu16_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 4, 3, 2, 1);
        let r = _mm_maskz_cvtepu16_epi32(0xF, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepu16_epi32(0xF, _mm_set1_epi16(rnd[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu16_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 4, 3, 2, 1);
        let src = _mm_setzero_si128();
        let r = _mm_mask_cvtepu16_epi64(src, 0xF, a);
        let out: [i64; 4] = std::mem::transmute::<__m256i, [i64; 4]>(r);
        check_array_equality(&out, &[1i64, 2i64, 3i64, 4i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepu16_epi64(_mm_setzero_si128(), 0xF, _mm_set1_epi16(rnd[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu16_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 4, 3, 2, 1);
        let r = _mm_maskz_cvtepu16_epi64(0xF, a);
        let out: [i64; 4] = std::mem::transmute::<__m256i, [i64; 4]>(r);
        check_array_equality(&out, &[1i64, 2i64, 3i64, 4i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepu16_epi64(0xF, _mm_set1_epi16(rnd[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let src = _mm_setzero_si128();
        let r = _mm_mask_cvtepi32_epi64(src, 0x3, a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepi32_epi64(_mm_setzero_si128(), 0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let r = _mm_maskz_cvtepi32_epi64(0x3, a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepi32_epi64(0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let src = _mm_setzero_si128();
        let r = _mm_mask_cvtepu32_epi64(src, 0x3, a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepu32_epi64(_mm_setzero_si128(), 0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu32_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let r = _mm_maskz_cvtepu32_epi64(0x3, a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepu32_epi64(0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let src = _mm_setzero_ps();
        let r = _mm_mask_cvtepi32_ps(src, 0xF, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepi32_ps(_mm_setzero_ps(), 0xF, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let r = _mm_maskz_cvtepi32_ps(0xF, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepi32_ps(0xF, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(2, 1, 0, 0);
        let src = _mm_setzero_pd();
        let r = _mm_mask_cvtepi32_pd(src, 0x3, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepi32_pd(_mm_setzero_pd(), 0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(2, 1, 0, 0);
        let r = _mm_maskz_cvtepi32_pd(0x3, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_maskz_cvtepi32_pd(0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(2, 1, 0, 0);
        let r = _mm_cvtepu32_pd(a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_cvtepu32_pd(_mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(2, 1, 0, 0);
        let src = _mm_setzero_pd();
        let r = _mm_mask_cvtepu32_pd(src, 0x3, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_i32_array::<4>();
                let _ = _mm_mask_cvtepu32_pd(_mm_setzero_pd(), 0x3, _mm_set1_epi32(rnd[0]));
            }
        }
    }
    Ok(())
}
