use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvtsepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_cvtusepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtusepi16_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi8_epi16() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi8_epi16() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu8_epi16() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcastb_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7);
        let result = {
            let bytes: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(a);
            let b = bytes[0] as i64 & 0xff;
            _mm_set1_epi64x(b)
        };
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[7i64, 7i64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = (vals[0] & 0xff) as i8;
                let a = _mm_set1_epi8(low);
                let _ = _mm_set1_epi64x((low as i64) & 0xff);
                let _ = a;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_broadcastb_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9);
        let result = {
            let bytes: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(a);
            let b = bytes[0] as i64 & 0xff;
            _mm_set1_epi64x(b)
        };
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[9i64, 9i64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = (vals[0] & 0xff) as i8;
                let a = _mm_set1_epi8(low);
                let _ = _mm_set1_epi64x((low as i64) & 0xff);
                let _ = a;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_broadcastw_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 123);
        let result = {
            let words: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(a);
            let w = words[0] as i64 & 0xa1;
            _mm_set1_epi64x(w)
        };
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[123i64, 123i64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = (vals[0] & 0xa1) as i16;
                let a = _mm_set1_epi16(low);
                let _ = _mm_set1_epi64x((low as i64) & 0xa1);
                let _ = a;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_broadcastw_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 77);
        let result = {
            let words: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(a);
            let w = words[0] as i64 & 0xa1;
            _mm_set1_epi64x(w)
        };
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[77i64, 77i64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = (vals[0] & 0xa1) as i16;
                let a = _mm_set1_epi16(low);
                let _ = _mm_set1_epi64x((low as i64) & 0xa1);
                let _ = a;
            }
        }
    }

    Ok(())
}
