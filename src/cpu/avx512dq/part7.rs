use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_reduce_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(3.5);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 3.5)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(2.25);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 2.25)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(1.75);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 1.75)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(9.0);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 9.0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_ss() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_ss() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(f64::INFINITY, f64::NAN);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[f64::NAN, f64::INFINITY])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[0.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, f32::NAN, f32::INFINITY, 0.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[0.0, f32::INFINITY, f32::NAN, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0, 3.0, 4.0, 5.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[5.0, 4.0, 3.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(f64::NAN);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, f64::NAN as f32)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(1.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 1.0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(f32::NAN);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, f32::NAN)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(2.5);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 2.5)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}
