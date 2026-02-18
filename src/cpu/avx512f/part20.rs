use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtusepi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(21, 22);
        let r = _mm_maskz_cvtusepi64_epi8(161, a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&[out[0] as i32, out[1] as i32], &[22, 21])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_maskz_cvtusepi64_epi8(161, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundps_ph() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_mask_cvt_roundps_ph::<0>(src, 161, v);
        let round = _mm_cvtph_ps(r);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(round);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_mask_cvt_roundps_ph::<0>(src, 161, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundps_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_maskz_cvt_roundps_ph::<0>(161, v);
        let round = _mm_cvtph_ps(r);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(round);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_maskz_cvt_roundps_ph::<0>(161, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_ph() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_mask_cvtps_ph::<0>(src, 161, v);
        let round = _mm_cvtph_ps(r);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(round);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_mask_cvtps_ph::<0>(src, 161, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtps_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_maskz_cvtps_ph::<0>(161, v);
        let round = _mm_cvtph_ps(r);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(round);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_maskz_cvtps_ph::<0>(161, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(0.0);
        let ph = _mm_cvtps_ph::<4>(_mm_set1_ps(3.0));
        let r = _mm_mask_cvtph_ps(src, 161, ph);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_set1_ps(0.0);
                let rnd = get_random_float32_array::<1>();
                let ph_r = _mm_cvtps_ph::<4>(_mm_set1_ps(rnd[0]));
                let _ = _mm_mask_cvtph_ps(src, 161, ph_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtph_ps() -> Result<(), String> {
    unsafe {
        let ph = _mm_cvtps_ph::<4>(_mm_set1_ps(3.0));
        let r = _mm_maskz_cvtph_ps(161, ph);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rnd = get_random_float32_array::<1>();
                let ph_r = _mm_cvtps_ph::<4>(_mm_set1_ps(rnd[0]));
                let _ = _mm_maskz_cvtph_ps(161, ph_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_ps(4.9, 3.9, 2.1, 1.1);
        let r = _mm_mask_cvttps_epi32(src, 15, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_mask_cvttps_epi32(src, 15, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.9, 3.9, 2.1, 1.1);
        let r = _mm_maskz_cvttps_epi32(15, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_maskz_cvttps_epi32(15, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.9, 3.9, 2.1, 1.1);
        let r = _mm_cvttps_epu32(a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_cvttps_epu32(v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_ps(4.9, 3.9, 2.1, 1.1);
        let r = _mm_mask_cvttps_epu32(src, 15, a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_mask_cvttps_epu32(src, 15, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.9, 3.9, 2.1, 1.1);
        let r = _mm_maskz_cvttps_epu32(15, a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let v_r = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let _ = _mm_maskz_cvttps_epu32(15, v_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_pd(2.9, 1.9);
        let r = _mm_mask_cvttpd_epi32(src, 3, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_mask_cvttpd_epi32(src, 3, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let r = _mm_maskz_cvttpd_epi32(3, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_maskz_cvttpd_epi32(3, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let r = _mm_cvttpd_epu32(a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_cvttpd_epu32(a_r);
            }
        }
    }
    Ok(())
}
