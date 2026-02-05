#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::check_array_equality;
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512CD;

impl ExtensionTest for AVX512CD {
    fn get_name() -> &'static str {
        "AVX-512 CD"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_broadcastmw_epi32, "test_mm_broadcastmw_epi32"),
            (&test_mm_broadcastmb_epi64, "test_mm_broadcastmb_epi64"),
            (&test_mm_conflict_epi32, "test_mm_conflict_epi32"),
            (&test_mm_mask_conflict_epi32, "test_mm_mask_conflict_epi32"),
            (&test_mm_maskz_conflict_epi32, "test_mm_maskz_conflict_epi32"),
            (&test_mm_conflict_epi64, "test_mm_conflict_epi64"),
            (&test_mm_mask_conflict_epi64, "test_mm_mask_conflict_epi64"),
            (&test_mm_maskz_conflict_epi64, "test_mm_maskz_conflict_epi64"),
            (&test_mm_lzcnt_epi32, "test_mm_lzcnt_epi32"),
            (&test_mm_mask_lzcnt_epi32, "test_mm_mask_lzcnt_epi32"),
            (&test_mm_maskz_lzcnt_epi32, "test_mm_maskz_lzcnt_epi32"),
            (&test_mm_lzcnt_epi64, "test_mm_lzcnt_epi64"),
            (&test_mm_mask_lzcnt_epi64, "test_mm_mask_lzcnt_epi64"),
            (&test_mm_maskz_lzcnt_epi64, "test_mm_maskz_lzcnt_epi64"),
        ]
    }
}

fn test_mm_broadcastmw_epi32() -> Result<(), String> {
    unsafe {
        let k = 0b10101010u16;
        let result = _mm_broadcastmw_epi32(k);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0b10101010, 0b10101010, 0b10101010, 0b10101010])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let k = rand::random::<u16>();
                let _ = _mm_broadcastmw_epi32(k);
            }
        }
    }

    Ok(())
}

fn test_mm_broadcastmb_epi64() -> Result<(), String> {
    unsafe {
        let k: u8 = 0xFF;
        let result = _mm_broadcastmb_epi64(k.try_into().unwrap());
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        check_array_equality(&result, &[0xFF, 0xFF])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let k: u8 = rand::random();
                let _ = _mm_broadcastmb_epi64(k.try_into().unwrap());
            }
        }
    }

    Ok(())
}

fn test_mm_conflict_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 1, 3);
        let result = _mm_conflict_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 0, 0, 2];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_conflict_epi32(a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_conflict_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi32(0);
        let a = _mm_set_epi32(1, 2, 1, 3);
        let result = _mm_mask_conflict_epi32(src, 0xF, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 0, 0, 2];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi32(rand::random());
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_mask_conflict_epi32(src, rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_conflict_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 1, 3);
        let result = _mm_maskz_conflict_epi32(0xF, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 0, 0, 2];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi32(rand::random(), rand::random(), rand::random(), rand::random());
                let _ = _mm_maskz_conflict_epi32(rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_conflict_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let result = _mm_conflict_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, 0];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_conflict_epi64(a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_conflict_epi64() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi64x(0);
        let a = _mm_set_epi64x(1, 2);
        let result = _mm_mask_conflict_epi64(src, 0x3, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, 0];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi64x(rand::random());
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_mask_conflict_epi64(src, rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_conflict_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let result = _mm_maskz_conflict_epi64(0x3, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, 0];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _ = _mm_maskz_conflict_epi64(rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_lzcnt_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [24, 24, 24, 24];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi32(rand::random());
                let _ = _mm_lzcnt_epi32(a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi32(100);
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_mask_lzcnt_epi32(src, 0b1100, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [100, 100, 24, 24];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi32(rand::random());
                let a = _mm_set1_epi32(rand::random());
                let _ = _mm_mask_lzcnt_epi32(src, rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_maskz_lzcnt_epi32(0b1100, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 0, 24, 24];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi32(rand::random());
                let _ = _mm_maskz_lzcnt_epi32(rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_lzcnt_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [56, 56];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let _ = _mm_lzcnt_epi64(a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi64x(100);
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_mask_lzcnt_epi64(src, 0b10, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [100, 56];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let src = _mm_set1_epi64x(rand::random());
                let a = _mm_set1_epi64x(rand::random());
                let _ = _mm_mask_lzcnt_epi64(src, rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_maskz_lzcnt_epi64(0b10, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, 56];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let _ = _mm_maskz_lzcnt_epi64(rand::random::<u8>(), a);
            }
        }
    }

    Ok(())
}
