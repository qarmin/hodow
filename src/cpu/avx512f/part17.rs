use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        // convert unsigned 32-bit ints to double precision floats with zero mask
        let a = _mm_set_epi32(2, 1, 0, 0);
        let r = _mm_maskz_cvtepu32_pd(3, a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(r);
        crate::cpu::common::check_float_array_equality(&result, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_maskz_cvtepu32_pd(3, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1000, -2000, 3000, -4000);
        let r = _mm_cvtepi32_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[-4000, 3000, -2000, 1000])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi32_epi16(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_epi32(7, 6, 5, 4);
        let r = _mm_mask_cvtepi32_epi16(src, 161, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[4, 5, 6, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let src = _mm_setzero_si128();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_mask_cvtepi32_epi16(src, 161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let r = _mm_maskz_cvtepi32_epi16(161, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[40, 30, 20, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_maskz_cvtepi32_epi16(161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_cvtepi32_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_cvtepi32_epi8(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_epi32(11, 12, 13, 14);
        let r = _mm_mask_cvtepi32_epi8(src, 161, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[14, 13, 12, 11])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let src = _mm_setzero_si128();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_mask_cvtepi32_epi8(src, 161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(21, 22, 23, 24);
        let r = _mm_maskz_cvtepi32_epi8(161, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32], &[24, 23, 22, 21])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rnd[3], rnd[2], rnd[1], rnd[0]);
                let _ = _mm_maskz_cvtepi32_epi8(161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let r = _mm_cvtepi64_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&result, &[1, 2, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtepi64_epi32(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_epi64x(3, 4);
        let r = _mm_mask_cvtepi64_epi32(src, 15, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&result, &[4, 3, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let src = _mm_setzero_si128();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cvtepi64_epi32(src, 15, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(5, 6);
        let r = _mm_maskz_cvtepi64_epi32(15, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&result, &[6, 5, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_maskz_cvtepi64_epi32(15, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(300, -300);
        let r = _mm_cvtepi64_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32], &[-300, 300])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtepi64_epi16(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_epi64x(700, -700);
        let r = _mm_mask_cvtepi64_epi16(src, 161, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32], &[-700, 700])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let src = _mm_setzero_si128();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cvtepi64_epi16(src, 161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(800, -800);
        let r = _mm_maskz_cvtepi64_epi16(161, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32], &[-800, 800])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_maskz_cvtepi64_epi16(161, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let r = _mm_cvtepi64_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32], &[2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_cvtepi64_epi8(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_epi64x(9, 10);
        let r = _mm_mask_cvtepi64_epi8(src, 161, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(r);
        crate::cpu::common::check_array_equality(&[result[0] as i32, result[1] as i32], &[10, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rv = crate::cpu::common::get_random_i64_array::<2>();
                let src = _mm_setzero_si128();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_cvtepi64_epi8(src, 161, a_r);
            }
        }
    }

    Ok(())
}
