use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::get_random_i32_array;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_compress_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, 2.0, 0.0);
        let m: u8 = 0b0101u8;
        let r = _mm_mask_compress_ps(_mm_setzero_ps(), m, a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_compress_ps(_mm_setzero_ps(), 0, _mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_ps() -> Result<(), String> {
    test_mm_mask_compress_ps()
}

pub(super) fn test_mm_mask_compress_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let m: u8 = 0b01u8;
        let r = _mm_mask_compress_pd(_mm_setzero_pd(), m, a);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_compress_pd(_mm_setzero_pd(), 0, _mm_set1_pd(get_random_i32_array::<4>()[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_pd() -> Result<(), String> {
    test_mm_mask_compress_pd()
}

pub(super) fn test_mm_mask_compressstoreu_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 0, 2, 0);
        let mut buf = [0i32; 4];
        _mm_mask_compressstoreu_epi32(buf.as_mut_ptr(), 0b0101u8, a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0i32; 4];
                _mm_mask_compressstoreu_epi32(buf.as_mut_ptr(), 0, _mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compressstoreu_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let mut buf = [0i64; 2];
        _mm_mask_compressstoreu_epi64(buf.as_mut_ptr(), 0b01u8, a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let mut buf = [0i64; 2];
                _mm_mask_compressstoreu_epi64(buf.as_mut_ptr(), 0, _mm_set_epi64x(rnd[0] as i64, rnd[1] as i64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compressstoreu_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 0.0, 2.0, 0.0);
        let mut buf = [0f32; 4];
        _mm_mask_compressstoreu_ps(buf.as_mut_ptr(), 0b0101u8, a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let mut buf = [0f32; 4];
                _mm_mask_compressstoreu_ps(buf.as_mut_ptr(), 0, _mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compressstoreu_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let mut buf = [0f64; 2];
        _mm_mask_compressstoreu_pd(buf.as_mut_ptr(), 0b01u8, a);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let mut buf = [0f64; 2];
                _mm_mask_compressstoreu_pd(buf.as_mut_ptr(), 0, _mm_set1_pd(get_random_i32_array::<4>()[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_expand_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_mask_expand_epi32(_mm_setzero_si128(), 0b1010u8, a);
        let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_expand_epi32(_mm_setzero_si128(), 0, _mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expand_epi32() -> Result<(), String> {
    test_mm_mask_expand_epi32()
}

pub(super) fn test_mm_mask_expand_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let r = _mm_mask_expand_epi64(_mm_setzero_si128(), 0b01u8, a);
        let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_expand_epi64(_mm_setzero_si128(), 0, _mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expand_epi64() -> Result<(), String> {
    test_mm_mask_expand_epi64()
}

pub(super) fn test_mm_mask_expand_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_mask_expand_ps(_mm_setzero_ps(), 0b1010u8, a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_expand_ps(_mm_setzero_ps(), 0, _mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expand_ps() -> Result<(), String> {
    test_mm_mask_expand_ps()
}

pub(super) fn test_mm_mask_expand_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let r = _mm_mask_expand_pd(_mm_setzero_pd(), 0b01u8, a);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_mask_expand_pd(_mm_setzero_pd(), 0, _mm_set1_pd(get_random_i32_array::<4>()[0] as f64));
            }
        }
    }
    Ok(())
}
