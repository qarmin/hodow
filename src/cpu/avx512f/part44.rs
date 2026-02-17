use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::check_float_array_equality;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_add_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(2.5);
        let b = _mm_set_sd(1.5);
        let result_v = _mm_maskz_add_sd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_maskz_add_sd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(4.0);
        let b = _mm_set_ss(1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_sub_ss(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_sub_ss(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(4.0);
        let b = _mm_set_ss(1.0);
        let result_v = _mm_maskz_sub_ss(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_sub_ss(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(5.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_sub_sd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_mask_sub_sd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(5.0);
        let b = _mm_set_sd(2.0);
        let result_v = _mm_maskz_sub_sd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_maskz_sub_sd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(2.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_mul_ss(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[6.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_mul_ss(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(2.0);
        let result_v = _mm_maskz_mul_ss(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[6.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_mul_ss(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_mul_sd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[6.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_mask_mul_sd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let result_v = _mm_maskz_mul_sd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[6.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_maskz_mul_sd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(6.0);
        let b = _mm_set_ss(2.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_div_ss(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_div_ss(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(6.0);
        let b = _mm_set_ss(2.0);
        let result_v = _mm_maskz_div_ss(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&[result[0]], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_div_ss(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(6.0);
        let b = _mm_set_sd(2.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_div_sd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_mask_div_sd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(6.0);
        let b = _mm_set_sd(2.0);
        let result_v = _mm_maskz_div_sd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&[result[0] as f32], &[3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_maskz_div_sd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(5.0);
        let b = _mm_set_ss(3.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_max_ss(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        crate::cpu::common::check_float_equality(result[0], 5.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_max_ss(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(5.0);
        let b = _mm_set_ss(3.0);
        let result_v = _mm_maskz_max_ss(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        crate::cpu::common::check_float_equality(result[0], 5.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_max_ss(k, a_r, b_r);
            }
        }
    }
    Ok(())
}
