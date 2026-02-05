#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{check_array_equality, check_f32_array_equality, get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "AVX-512 VBMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_permutex2var_epi8, "test_mm_permutex2var_epi8"),
            (&test_mm_mask_permutex2var_epi8, "test_mm_mask_permutex2var_epi8"),
            (&test_mm_maskz_permutex2var_epi8, "test_mm_maskz_permutex2var_epi8"),
            (&test_mm_mask2_permutex2var_epi8, "test_mm_mask2_permutex2var_epi8"),
            (&test_mm_permutexvar_epi8, "test_mm_permutexvar_epi8"),
            (&test_mm_mask_permutexvar_epi8, "test_mm_mask_permutexvar_epi8"),
            (&test_mm_maskz_permutexvar_epi8, "test_mm_maskz_permutexvar_epi8"),
            (&test_mm_multishift_epi64_epi8, "test_mm_multishift_epi64_epi8"),
            (&test_mm_mask_multishift_epi64_epi8, "test_mm_mask_multishift_epi64_epi8"),
            (&test_mm_maskz_multishift_epi64_epi8, "test_mm_maskz_multishift_epi64_epi8"),
        ]
    }
}

fn test_mm_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0x1);
        let idx = _mm_set_epi8(7, 6, 5, 4, 3, 2, 1, 0, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_permutex2var_epi8(a, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected: [i8; 16] = [1; 16];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let _ = _mm_permutex2var_epi8(a, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_mask_permutex2var_epi8(a, 0xFFFF, idx, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let b = _mm_set1_epi8(rand::random());
                let _ = _mm_mask_permutex2var_epi8(a, 0xFFFF, idx, b);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_maskz_permutex2var_epi8(0xFF00, a, idx, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        let expected = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let b = _mm_set1_epi8(rand::random());
                let _ = _mm_maskz_permutex2var_epi8(0xFF00, a, idx, b);
            }
        }
    }

    Ok(())
}

fn test_mm_mask2_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_mask2_permutex2var_epi8(a, idx, 0xFFFF, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let b = _mm_set1_epi8(rand::random());
                let _ = _mm_mask2_permutex2var_epi8(a, idx, 0xFFFF, b);
            }
        }
    }

    Ok(())
}

fn test_mm_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_permutexvar_epi8(idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let a = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let _ = _mm_permutexvar_epi8(idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi8(99);
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_mask_permutexvar_epi8(src, 0xFF00, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        let expected = [99, 99, 99, 99, 99, 99, 99, 99, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi8(rand::random());
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let a = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let _ = _mm_mask_permutexvar_epi8(src, 0xFF00, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_maskz_permutexvar_epi8(0xFF00, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        let expected = [0, 0, 0, 0, 0, 0, 0, 0, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let idx = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let a = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let _ = _mm_maskz_permutexvar_epi8(0xFF00, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(0x0102030405060708u64 as i64, 0x090A0B0C0D0E0F10u64 as i64);
        let result = _mm_multishift_epi64_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let expected = [0x10, 0x0F, 0x0E, 0x0D, 0x0C, 0x0B, 0x0A, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let b = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_multishift_epi64_epi8(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi8(99);
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(0x0102030405060708u64 as i64, 0x090A0B0C0D0E0F10u64 as i64);
        let result = _mm_mask_multishift_epi64_epi8(src, 0xFF00, a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        let expected = [99, 99, 99, 99, 99, 99, 99, 99, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi8(rand::random());
                let a = _mm_set1_epi8(rand::random());
                let b = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_mask_multishift_epi64_epi8(src, 0xFF00, a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(0x0102030405060708u64 as i64, 0x090A0B0C0D0E0F10u64 as i64);
        let result = _mm_maskz_multishift_epi64_epi8(0xFF00, a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        let expected = [0, 0, 0, 0, 0, 0, 0, 0, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi8(rand::random());
                let b = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_maskz_multishift_epi64_epi8(0xFF00, a, b);
            }
        }
    }

    Ok(())
}
