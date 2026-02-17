use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::get_random_i32_array;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 1, 1, 1, 1, 1, 1, 1, 1);
        let r = _mm_reduce_mul_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_mul_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_or_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 4, 8, 16, 32, 64, 128);
        let r = _mm_reduce_or_epi16(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_or_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi16() -> Result<(), String> {
    test_mm_reduce_or_epi16()
}

pub(super) fn test_mm_reduce_or_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 4, 8, 16, 32, 64, 127, 1, 2, 4, 8, 16, 32, 64, 127);
        let r = _mm_reduce_or_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_or_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_or_epi8() -> Result<(), String> {
    test_mm_reduce_or_epi8()
}

pub(super) fn test_mm_loadu_epi16() -> Result<(), String> {
    unsafe {
        let data = [1i16, 2, 3, 4, 5, 6, 7, 8];
        let r = _mm_loadu_epi16(data.as_ptr());
        let _out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_loadu_epi16(get_random_i32_array::<4>().as_ptr() as *const i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi8() -> Result<(), String> {
    unsafe {
        let data = [1i8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
        let r = _mm_loadu_epi8(data.as_ptr());
        let _out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_loadu_epi8(get_random_i32_array::<4>().as_ptr() as *const i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let mut buf = [0i16; 8];
        _mm_storeu_epi16(buf.as_mut_ptr(), a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                _mm_storeu_epi16(get_random_i32_array::<4>().as_ptr() as *mut i16, _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let mut buf = [0i8; 16];
        _mm_storeu_epi8(buf.as_mut_ptr(), a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                _mm_storeu_epi8(get_random_i32_array::<4>().as_ptr() as *mut i8, _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi16() -> Result<(), String> {
    unsafe {
        let data = [1i16, 2, 3, 4, 5, 6, 7, 8];
        // mask is __mmask8 -> use u8 literal
        let r = _mm_mask_loadu_epi16(_mm_set1_epi16(0), 15u8, data.as_ptr());
        let _out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_loadu_epi16(_mm_set1_epi16(0), 0u8, get_random_i32_array::<4>().as_ptr() as *const i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi16() -> Result<(), String> {
    test_mm_mask_loadu_epi16()
}

pub(super) fn test_mm_mask_loadu_epi8() -> Result<(), String> {
    unsafe {
        let data = [1i8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
        // mask is __mmask16 -> use u16 literal
        let r = _mm_mask_loadu_epi8(_mm_set1_epi8(0), 15u16, data.as_ptr());
        let _out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_loadu_epi8(_mm_set1_epi8(0), 0u16, get_random_i32_array::<4>().as_ptr() as *const i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi8() -> Result<(), String> {
    test_mm_mask_loadu_epi8()
}

pub(super) fn test_mm_mask_storeu_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let mut buf = [0i16; 8];
        // mask is __mmask8 -> use u8 literal
        _mm_mask_storeu_epi16(buf.as_mut_ptr(), 15u8, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut buf = [0i16; 8];
                _mm_mask_storeu_epi16(buf.as_mut_ptr(), 0u8, _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let mut buf = [0i8; 16];
        // mask is __mmask16 -> use u16 literal
        _mm_mask_storeu_epi8(buf.as_mut_ptr(), 15u16, a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut buf = [0i8; 16];
                _mm_mask_storeu_epi8(buf.as_mut_ptr(), 0u16, _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}
