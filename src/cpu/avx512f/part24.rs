use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_expand_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let m: u8 = 0b11u8;
        let r = _mm_maskz_expand_pd(m, a);
        let result: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_array_equality(&result, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_expand_pd(0, _mm_set1_pd(get_random_i32_array::<4>()[0] as f64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rol_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_rol_epi32::<1>(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[2, 4, 6, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_rol_epi32::<1>(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_rol_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let src = _mm_setzero_si128();
        let m: u8 = 0b1111u8;
        let r = _mm_mask_rol_epi32::<1>(src, m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[2, 4, 6, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_mask_rol_epi32::<1>(_mm_setzero_si128(), 0, _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_rol_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let m: u8 = 0b1111u8;
        let r = _mm_maskz_rol_epi32::<1>(m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[2, 4, 6, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_rol_epi32::<1>(0, _mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ror_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(16, 8, 4, 2);
        let r = _mm_ror_epi32::<1>(a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[8, 4, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_ror_epi32::<1>(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_ror_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(16, 8, 4, 2);
        let src = _mm_setzero_si128();
        let m: u8 = 0b1111u8;
        let r = _mm_mask_ror_epi32::<1>(src, m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[8, 4, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_mask_ror_epi32::<1>(_mm_setzero_si128(), 0, _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_ror_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(16, 8, 4, 2);
        let m: u8 = 0b1111u8;
        let r = _mm_maskz_ror_epi32::<1>(m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[8, 4, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_ror_epi32::<1>(0, _mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rol_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let r = _mm_rol_epi64::<1>(a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[2, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _ = _mm_rol_epi64::<1>(_mm_set_epi64x(v[1] as i64, v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_rol_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let src = _mm_setzero_si128();
        let m: u8 = 0b11u8;
        let r = _mm_mask_rol_epi64::<1>(src, m, a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[2, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _ = _mm_mask_rol_epi64::<1>(_mm_setzero_si128(), 0, _mm_set_epi64x(v[1] as i64, v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_rol_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let m: u8 = 0b11u8;
        let r = _mm_maskz_rol_epi64::<1>(m, a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[2, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_rol_epi64::<1>(0, _mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_ror_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(16, 8);
        let r = _mm_ror_epi64::<1>(a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[8, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _ = _mm_ror_epi64::<1>(_mm_set_epi64x(v[1] as i64, v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_ror_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(16, 8);
        let src = _mm_setzero_si128();
        let m: u8 = 0b11u8;
        let r = _mm_mask_ror_epi64::<1>(src, m, a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[8, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _ = _mm_mask_ror_epi64::<1>(_mm_setzero_si128(), 0, _mm_set_epi64x(v[1] as i64, v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_ror_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(16, 8);
        let m: u8 = 0b11u8;
        let r = _mm_maskz_ror_epi64::<1>(m, a);
        let result: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&result, &[8, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_ror_epi64::<1>(0, _mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let src = _mm_setzero_si128();
        let m: u8 = 0b1111u8;
        let r = _mm_mask_slli_epi32::<3>(src, m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[8, 8, 8, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_slli_epi32::<3>(_mm_setzero_si128(), 0, _mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let m: u8 = 0b1111u8;
        let r = _mm_maskz_slli_epi32::<3>(m, a);
        let result: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&result, &[8, 8, 8, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_maskz_slli_epi32::<3>(0, _mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }

    Ok(())
}
