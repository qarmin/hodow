use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{get_random_i32_array, get_random_i64_array};

pub(super) fn test_mm_mask_rolv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_mask_rolv_epi32(_mm_setzero_si128(), 15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 1, 3, 5])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_rolv_epi32(_mm_setzero_si128(), 15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rolv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_maskz_rolv_epi32(15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 1, 3, 5])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_rolv_epi32(15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rorv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_rorv_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2147483648, 1, 3, 2])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_rorv_epi32(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rorv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_mask_rorv_epi32(_mm_setzero_si128(), 15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2147483648, 1, 3, 2])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_rorv_epi32(_mm_setzero_si128(), 15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rorv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_maskz_rorv_epi32(15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2147483648, 1, 3, 2])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_rorv_epi32(15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rolv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_rolv_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_rolv_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rolv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_mask_rolv_epi64(_mm_setzero_si128(), 161, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_rolv_epi64(_mm_setzero_si128(), 161, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rolv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_maskz_rolv_epi64(161, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_rolv_epi64(161, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rorv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_rorv_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[9223372036854775808, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_rorv_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rorv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_mask_rorv_epi64(_mm_setzero_si128(), 161, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[9223372036854775808, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_rorv_epi64(_mm_setzero_si128(), 161, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rorv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set1_epi64x(1);
        let r = _mm_maskz_rorv_epi64(161, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        crate::cpu::common::check_array_equality(&out, &[9223372036854775808, 1])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_rorv_epi64(161, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sllv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_mask_sllv_epi32(_mm_setzero_si128(), 15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 4, 6, 8])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_sllv_epi32(_mm_setzero_si128(), 15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sllv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set1_epi32(1);
        let r = _mm_maskz_sllv_epi32(15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[2, 4, 6, 8])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_sllv_epi32(15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srlv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(8, 4, 2, 1);
        let b = _mm_set1_epi32(1);
        let r = _mm_mask_srlv_epi32(_mm_setzero_si128(), 15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[4, 2, 1, 0])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_srlv_epi32(_mm_setzero_si128(), 15, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srlv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(8, 4, 2, 1);
        let b = _mm_set1_epi32(1);
        let r = _mm_maskz_srlv_epi32(15, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        crate::cpu::common::check_array_equality(&out, &[4, 2, 1, 0])?;

        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_srlv_epi32(15, a_r, b_r);
            }
        }
    }
    Ok(())
}
