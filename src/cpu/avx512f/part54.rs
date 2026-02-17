#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let r = _mm_fmadd_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fmadd_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fmadd_ss(a, k, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask_fmadd_ss(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fmadd_ss(k, a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_maskz_fmadd_ss(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fmadd_ss(a, b, c, k);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask3_fmadd_ss(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let r = _mm_fmadd_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fmadd_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fmadd_sd(a, k, b, c);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_mask_fmadd_sd(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fmadd_sd(k, a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_maskz_fmadd_sd(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fmadd_sd(a, b, c, k);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_mask3_fmadd_sd(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(5.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let r = _mm_fmsub_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        // 5*2-3 = 7
        check_float_array_equality(&out, &[7.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fmsub_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(5.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fmsub_ss(a, k, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[7.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask_fmsub_ss(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(5.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fmsub_ss(k, a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[7.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_maskz_fmsub_ss(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(5.0f32);
        let b = _mm_set_ss(2.0f32);
        let c = _mm_set_ss(3.0f32);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fmsub_ss(a, b, c, k);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[7.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask3_fmsub_ss(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(5.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let r = _mm_fmsub_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[7.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fmsub_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(5.0f64);
        let b = _mm_set_sd(2.0f64);
        let c = _mm_set_sd(3.0f64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fmsub_sd(a, k, b, c);
        let out: [f64; 2] = std::mem::transmute::<__mm128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[7.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_mask_fmsub_sd(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}
