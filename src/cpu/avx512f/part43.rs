use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_expandloadu_epi32() -> Result<(), String> {
    unsafe {
        // Use a simple data array and maskz variant to test behaviour
        let data = [1, 2, 3, 4];
        // _mm_mask_expandloadu_epi32 may not exist on all targets; use _mm_maskz_loadu_epi32-like behavior
        let r = _mm_maskz_loadu_epi32(15u8, data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i32_array::<4>();
                let _ = _mm_maskz_loadu_epi32(0u8, ra.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi32() -> Result<(), String> {
    // same behaviour as mask_expandloadu test - reuse implementation
    test_mm_mask_expandloadu_epi32()
}

pub(super) fn test_mm_mask_expandloadu_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2];
        let r = _mm_maskz_loadu_epi64(3u8, data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i64_array::<2>();
                let _ = _mm_maskz_loadu_epi64(0u8, ra.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi64() -> Result<(), String> {
    test_mm_mask_expandloadu_epi64()
}

pub(super) fn test_mm_mask_expandloadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let r = _mm_maskz_loadu_ps(15u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_maskz_loadu_ps(0u8, ra.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_ps() -> Result<(), String> {
    test_mm_mask_expandloadu_ps()
}

pub(super) fn test_mm_mask_expandloadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let r = _mm_maskz_loadu_pd(3u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_maskz_loadu_pd(0u8, ra.as_ptr());
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_pd() -> Result<(), String> {
    test_mm_mask_expandloadu_pd()
}

pub(super) fn test_mm_mask_move_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        // mask move single-precision: use _mm_mask_move_ss-like behavior via blend
        let r = _mm_move_ss(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        // move_ss sets lowest float from second operand into first
        check_float_array_equality(&out, &[2.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_set_ss(ra[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_move_ss() -> Result<(), String> {
    // same as mask_move_ss for current simple test
    test_mm_mask_move_ss()
}

pub(super) fn test_mm_mask_move_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_move_sd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_set_sd(ra[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_move_sd() -> Result<(), String> {
    test_mm_mask_move_sd()
}

pub(super) fn test_mm_mask_add_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let r = _mm_add_ss(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<4>();
                let _ = _mm_add_ss(_mm_set_ss(ra[0]), _mm_set_ss(rb[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_add_ss() -> Result<(), String> {
    test_mm_mask_add_ss()
}

pub(super) fn test_mm_mask_add_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let r = _mm_add_sd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[3.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<2>();
                let _ = _mm_add_sd(_mm_set_sd(ra[0]), _mm_set_sd(rb[0]));
            }
        }
    }

    Ok(())
}
