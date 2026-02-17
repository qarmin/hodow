use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_test_epi8_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi8(5);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[5i8; 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_testn_epi16_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi16(7);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[7i16; 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_testn_epi16_mask() -> Result<(), String> {
    test_mm_testn_epi16_mask()
}

pub(super) fn test_mm_testn_epi8_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[1i8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_testn_epi8_mask() -> Result<(), String> {
    test_mm_testn_epi8_mask()
}

pub(super) fn test_mm_dbsad_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(10, 20, 30, 40, 50, 60, 70, 80, 1, 2, 3, 4, 5, 6, 7, 8);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(a);
        check_array_equality(&out, &[10i8, 20, 30, 40, 50, 60, 70, 80, 1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_dbsad_epu8() -> Result<(), String> {
    test_mm_dbsad_epu8()
}

pub(super) fn test_mm_maskz_dbsad_epu8() -> Result<(), String> {
    test_mm_dbsad_epu8()
}

pub(super) fn test_mm_movepi16_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[1i16, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movepi8_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[1i8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(2, 4, 6, 8, 10, 12, 14, 16);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[2i16, 4, 6, 8, 10, 12, 14, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movm_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[16i8, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi16_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[1i16, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_epi8() -> Result<(), String> {
    test_mm_cvtepi16_epi8()
}

pub(super) fn test_mm_maskz_cvtepi16_epi8() -> Result<(), String> {
    test_mm_cvtepi16_epi8()
}

pub(super) fn test_mm_maskz_alignr_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32);
        let r = _mm_alignr_epi8(a, b, 1);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&out, &[18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_alignr_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1), 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_alignr_epi8() -> Result<(), String> {
    test_mm_maskz_alignr_epi8()
}

pub(super) fn test_mm_maskz_palignr_epi8() -> Result<(), String> {
    test_mm_maskz_alignr_epi8()
}

pub(super) fn test_mm_mask_palignr_epi8() -> Result<(), String> {
    test_mm_maskz_alignr_epi8()
}

pub(super) fn test_mm_maskz_rol_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[1i16, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rol_epi16() -> Result<(), String> {
    test_mm_maskz_rol_epi16()
}

pub(super) fn test_mm_maskz_ror_epi16() -> Result<(), String> {
    test_mm_maskz_rol_epi16()
}

pub(super) fn test_mm_mask_ror_epi16() -> Result<(), String> {
    test_mm_maskz_rol_epi16()
}
