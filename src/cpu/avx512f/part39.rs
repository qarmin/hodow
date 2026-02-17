use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cmpge_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set1_epi64x(1);
        let m = _mm_cmpge_epi64_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpge_epi64_mask(_mm_set1_epi64x(get_random_i64_array::<2>()[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 1);
        let m = _mm_cmpeq_epi64_mask(a, a);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpeq_epi64_mask(_mm_set1_epi64x(get_random_i64_array::<2>()[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpeq_epi64_mask() -> Result<(), String> {
    test_mm_cmpeq_epi64_mask()
}

pub(super) fn test_mm_cmpneq_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let m = _mm_cmpneq_epi64_mask(a, a);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpneq_epi64_mask(_mm_set1_epi64x(get_random_i64_array::<2>()[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epi64_mask() -> Result<(), String> {
    test_mm_cmpneq_epi64_mask()
}

pub(super) fn test_mm_cmp_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 4);
        let b = _mm_set_epi64x(1, 2);
        // use the dedicated greater-than mask intrinsic
        let m = _mm_cmpgt_epi64_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpgt_epi64_mask(_mm_set1_epi64x(get_random_i64_array::<2>()[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epi64_mask() -> Result<(), String> {
    test_mm_cmp_epi64_mask()
}

pub(super) fn test_mm_loadu_epi32() -> Result<(), String> {
    unsafe {
        let data = [1, 2, 3, 4];
        let r = _mm_loadu_epi32(data.as_ptr());
        let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_loadu_epi32(get_random_i32_array::<4>().as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0; 4];
        _mm_mask_cvtepi32_storeu_epi16(buf.as_mut_ptr(), 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtepi32_storeu_epi16(buf.as_mut_ptr(), 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1, -2, -3, -4);
        let mut buf = [0; 4];
        _mm_mask_cvtsepi32_storeu_epi16(buf.as_mut_ptr(), 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtsepi32_storeu_epi16(buf.as_mut_ptr(), 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0; 4];
        _mm_mask_cvtusepi32_storeu_epi16(buf.as_mut_ptr() as *mut i16, 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtusepi32_storeu_epi16(buf.as_mut_ptr() as *mut i16, 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0; 4];
        _mm_mask_cvtepi32_storeu_epi8(buf.as_mut_ptr(), 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtepi32_storeu_epi8(buf.as_mut_ptr(), 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1, -2, -3, -4);
        let mut buf = [0; 4];
        _mm_mask_cvtsepi32_storeu_epi8(buf.as_mut_ptr(), 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtsepi32_storeu_epi8(buf.as_mut_ptr(), 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let mut buf = [0; 4];
        _mm_mask_cvtusepi32_storeu_epi8(buf.as_mut_ptr() as *mut i8, 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0; 4];
                _mm_mask_cvtusepi32_storeu_epi8(buf.as_mut_ptr() as *mut i8, 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let mut buf = [0; 2];
        _mm_mask_cvtepi64_storeu_epi16(buf.as_mut_ptr(), 0, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i64_array::<2>();
                let mut buf = [0; 2];
                _mm_mask_cvtepi64_storeu_epi16(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0], rnd[1]));
            }
        }
    }
    Ok(())
}
