use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_mov_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let res: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(a);
        check_array_equality(&res, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi8(
                    vals[0] as i8,
                    vals[1] as i8,
                    vals[2] as i8,
                    vals[3] as i8,
                    vals[0] as i8,
                    vals[1] as i8,
                    vals[2] as i8,
                    vals[3] as i8,
                    vals[0] as i8,
                    vals[1] as i8,
                    vals[2] as i8,
                    vals[3] as i8,
                    vals[0] as i8,
                    vals[1] as i8,
                    vals[2] as i8,
                    vals[3] as i8,
                );
                let _ = a;
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let res: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(a);
        check_array_equality(&res, &[16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi8(
                    vals[3] as i8,
                    vals[2] as i8,
                    vals[1] as i8,
                    vals[0] as i8,
                    vals[3] as i8,
                    vals[2] as i8,
                    vals[1] as i8,
                    vals[0] as i8,
                    vals[3] as i8,
                    vals[2] as i8,
                    vals[1] as i8,
                    vals[0] as i8,
                    vals[3] as i8,
                    vals[2] as i8,
                    vals[1] as i8,
                    vals[0] as i8,
                );
                let _ = a;
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_set1_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi16(12345);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[12345, 12345, 12345, 12345, 12345, 12345, 12345, 12345])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>()[0] as i16;
                let _ = _mm_set1_epi16(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_set1_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi16(32767);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[32767; 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>()[0] as i16;
                let _ = _mm_set1_epi16(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_set1_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi8(-8);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[-8; 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>()[0] as i8;
                let _ = _mm_set1_epi8(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 1, 2, 3, 4);
        let res = _mm_shufflelo_epi16(a, 0);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(res);
        check_array_equality(&out, &[4, 4, 4, 4, 0, 0, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = vals[0] as i16;
                let a = _mm_set_epi16(0, 0, 0, 0, low, (low + 1) as i16, (low + 2) as i16, (low + 3) as i16);
                let _ = _mm_shufflelo_epi16(a, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 5, 6, 7, 8);
        let res = _mm_shufflelo_epi16(a, 0);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(res);
        check_array_equality(&out, &[8, 8, 8, 8, 0, 0, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let low = vals[0] as i16;
                let a = _mm_set_epi16(0, 0, 0, 0, low, (low + 1) as i16, (low + 2) as i16, (low + 3) as i16);
                let _ = _mm_shufflelo_epi16(a, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(40, 30, 20, 10, 0, 0, 0, 0);
        let res = _mm_shufflehi_epi16(a, 0);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(res);
        check_array_equality(&out, &[0, 0, 0, 0, 10, 10, 10, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let high = vals[0] as i16;
                let a = _mm_set_epi16(high, (high + 1) as i16, (high + 2) as i16, (high + 3) as i16, 0, 0, 0, 0);
                let _ = _mm_shufflehi_epi16(a, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(9, 8, 7, 6, 0, 0, 0, 0);
        let res = _mm_shufflehi_epi16(a, 0);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(res);
        check_array_equality(&out, &[0, 0, 0, 0, 6, 6, 6, 6])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let high = vals[0] as i16;
                let a = _mm_set_epi16(high, (high + 1) as i16, (high + 2) as i16, (high + 3) as i16, 0, 0, 0, 0);
                let _ = _mm_shufflehi_epi16(a, 0);
            }
        }
    }

    Ok(())
}
