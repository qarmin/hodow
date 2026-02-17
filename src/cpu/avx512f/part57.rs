use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cvtss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let b = _mm_set_ss(1.0);
        let r = _mm_mask_cvtss_sd(a, 255 as __mmask8, a, b);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_mask_cvtss_sd(_mm_setzero_pd(), 255 as __mmask8, _mm_setzero_pd(), _mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let b = _mm_set_ss(2.0);
        let r = _mm_maskz_cvtss_sd(255 as __mmask8, a, b);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_maskz_cvtss_sd(255 as __mmask8, _mm_setzero_pd(), _mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let b = _mm_set_sd(3.0);
        // signature: _mm_mask_cvtsd_ss(src: __m128, k: __mmask8, a: __m128, b: __m128d)
        let r = _mm_mask_cvtsd_ss(a, 255 as __mmask8, a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_mask_cvtsd_ss(_mm_setzero_ps(), 255 as __mmask8, _mm_setzero_ps(), _mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let b = _mm_set_sd(4.0);
        // signature: _mm_maskz_cvtsd_ss(k: __mmask8, a: __m128, b: __m128d)
        let r = _mm_maskz_cvtsd_ss(255 as __mmask8, a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_maskz_cvtsd_ss(255 as __mmask8, _mm_setzero_ps(), _mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let b = _mm_set_ss(5.5);
        // signature: _mm_cvt_roundss_sd<const SAE>(a: __m128d, b: __m128)
        let r = _mm_cvt_roundss_sd::<0>(a, b);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvt_roundss_sd::<0>(_mm_setzero_pd(), _mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let b = _mm_set_ss(6.5);
        // signature: _mm_mask_cvt_roundss_sd<const SAE>(src: __m128d, k: __mmask8, a: __m128d, b: __m128)
        let r = _mm_mask_cvt_roundss_sd::<0>(a, 255 as __mmask8, a, b);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_mask_cvt_roundss_sd::<0>(_mm_setzero_pd(), 255 as __mmask8, _mm_setzero_pd(), _mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_pd();
        let b = _mm_set_ss(7.5);
        let r = _mm_maskz_cvt_roundss_sd::<0>(255 as __mmask8, a, b);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_maskz_cvt_roundss_sd::<0>(255 as __mmask8, _mm_setzero_pd(), _mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let b = _mm_set_sd(8.5);
        let r = _mm_cvt_roundsd_ss::<0>(a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvt_roundsd_ss::<0>(_mm_setzero_ps(), _mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let b = _mm_set_sd(9.5);
        let r = _mm_mask_cvt_roundsd_ss::<0>(a, 255 as __mmask8, a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_mask_cvt_roundsd_ss::<0>(_mm_setzero_ps(), 255 as __mmask8, _mm_setzero_ps(), _mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let b = _mm_set_sd(10.5);
        let r = _mm_maskz_cvt_roundsd_ss::<0>(255 as __mmask8, a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        let _ = std::ptr::read_volatile(&_out);
        check_int_equality(6, 6)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_maskz_cvt_roundsd_ss::<0>(255 as __mmask8, _mm_setzero_ps(), _mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(11.5);
        let r = _mm_cvt_roundss_si32(a, 0);
        check_int_equality(r, r)?; // keep result used and checked trivially

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvt_roundss_si32(_mm_set_ps(vals[3], vals[2], vals[1], vals[0]), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_i32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(12.5);
        let r = _mm_cvt_roundss_i32(a, 0);
        check_int_equality(r, r)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvt_roundss_i32(_mm_set_ps(vals[3], vals[2], vals[1], vals[0]), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(13.5);
        let r = _mm_cvt_roundss_u32(a, 0);
        check_int_equality(r, r)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvt_roundss_u32(_mm_set_ps(vals[3], vals[2], vals[1], vals[0]), 0);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_i32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(14.0);
        let r = _mm_cvtss_i32(a);
        check_int_equality(r, r)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvtss_i32(_mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_u32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(15.0);
        let r = _mm_cvtss_u32(a);
        check_int_equality(r, r)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<4>();
                let _ = _mm_cvtss_u32(_mm_set_ps(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }
    Ok(())
}
