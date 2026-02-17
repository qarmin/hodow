use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fmsub_sd(k, a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
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
                let _ = _mm_maskz_fmsub_sd(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fmsub_sd(a, b, c, k);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
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
                let _ = _mm_mask3_fmsub_sd(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let r = _mm_fnmadd_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fnmadd_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fnmadd_ss(a, k, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask_fnmadd_ss(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fnmadd_ss(k, a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_maskz_fnmadd_ss(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fnmadd_ss(a, b, c, k);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask3_fnmadd_ss(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let r = _mm_fnmadd_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fnmadd_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fnmadd_sd(a, k, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_mask_fnmadd_sd(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fnmadd_sd(k, a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_maskz_fnmadd_sd(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fnmadd_sd(a, b, c, k);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-5.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_mask3_fnmadd_sd(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let r = _mm_fnmsub_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-10.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fnmsub_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask_fnmsub_ss(a, k, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-10.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask_fnmsub_ss(a_r, k, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_maskz_fnmsub_ss(k, a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-10.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_maskz_fnmsub_ss(k, a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        let b = _mm_set_ss(3.0);
        let c = _mm_set_ss(4.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let r = _mm_mask3_fnmsub_ss(a, b, c, k);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-10.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_mask3_fnmsub_ss(a_r, b_r, c_r, k);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let r = _mm_fnmsub_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-7.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fnmsub_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}
