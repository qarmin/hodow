use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512VBMI2;

impl ExtensionTest for AVX512VBMI2 {
    fn get_name() -> &'static str {
        "AVX512VBMI2"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_mask_expandloadu_epi16, "test_mm_mask_expandloadu_epi16"),
            (&test_mm_maskz_expandloadu_epi16, "test_mm_maskz_expandloadu_epi16"),
            (&test_mm_mask_expandloadu_epi8, "test_mm_mask_expandloadu_epi8"),
            (&test_mm_maskz_expandloadu_epi8, "test_mm_maskz_expandloadu_epi8"),
            (&test_mm_mask_compressstoreu_epi16, "test_mm_mask_compressstoreu_epi16"),
            (&test_mm_mask_compressstoreu_epi8, "test_mm_mask_compressstoreu_epi8"),
            (&test_mm_mask_compress_epi16, "test_mm_mask_compress_epi16"),
            (&test_mm_maskz_compress_epi16, "test_mm_maskz_compress_epi16"),
            (&test_mm_mask_compress_epi8, "test_mm_mask_compress_epi8"),
            (&test_mm_maskz_compress_epi8, "test_mm_maskz_compress_epi8"),
            (&test_mm_mask_expand_epi16, "test_mm_mask_expand_epi16"),
            (&test_mm_maskz_expand_epi16, "test_mm_maskz_expand_epi16"),
            (&test_mm_mask_expand_epi8, "test_mm_mask_expand_epi8"),
            (&test_mm_maskz_expand_epi8, "test_mm_maskz_expand_epi8"),
            (&test_mm_shldv_epi64, "test_mm_shldv_epi64"),
            (&test_mm_mask_shldv_epi64, "test_mm_mask_shldv_epi64"),
            (&test_mm_maskz_shldv_epi64, "test_mm_maskz_shldv_epi64"),
            (&test_mm_shldv_epi32, "test_mm_shldv_epi32"),
            (&test_mm_mask_shldv_epi32, "test_mm_mask_shldv_epi32"),
            (&test_mm_maskz_shldv_epi32, "test_mm_maskz_shldv_epi32"),
            (&test_mm_shldv_epi16, "test_mm_shldv_epi16"),
            (&test_mm_mask_shldv_epi16, "test_mm_mask_shldv_epi16"),
            (&test_mm_maskz_shldv_epi16, "test_mm_maskz_shldv_epi16"),
            (&test_mm_shrdv_epi64, "test_mm_shrdv_epi64"),
            (&test_mm_mask_shrdv_epi64, "test_mm_mask_shrdv_epi64"),
            (&test_mm_maskz_shrdv_epi64, "test_mm_maskz_shrdv_epi64"),
            (&test_mm_shrdv_epi32, "test_mm_shrdv_epi32"),
            (&test_mm_mask_shrdv_epi32, "test_mm_mask_shrdv_epi32"),
            (&test_mm_maskz_shrdv_epi32, "test_mm_maskz_shrdv_epi32"),
            (&test_mm_shrdv_epi16, "test_mm_shrdv_epi16"),
            (&test_mm_mask_shrdv_epi16, "test_mm_mask_shrdv_epi16"),
            (&test_mm_maskz_shrdv_epi16, "test_mm_maskz_shrdv_epi16"),
            (&test_mm_shldi_epi64, "test_mm_shldi_epi64"),
            (&test_mm_mask_shldi_epi64, "test_mm_mask_shldi_epi64"),
            (&test_mm_maskz_shldi_epi64, "test_mm_maskz_shldi_epi64"),
            (&test_mm_shldi_epi32, "test_mm_shldi_epi32"),
            (&test_mm_mask_shldi_epi32, "test_mm_mask_shldi_epi32"),
            (&test_mm_maskz_shldi_epi32, "test_mm_maskz_shldi_epi32"),
            (&test_mm_shldi_epi16, "test_mm_shldi_epi16"),
            (&test_mm_mask_shldi_epi16, "test_mm_mask_shldi_epi16"),
            (&test_mm_maskz_shldi_epi16, "test_mm_maskz_shldi_epi16"),
            (&test_mm_shrdi_epi64, "test_mm_shrdi_epi64"),
            (&test_mm_mask_shrdi_epi64, "test_mm_mask_shrdi_epi64"),
            (&test_mm_maskz_shrdi_epi64, "test_mm_maskz_shrdi_epi64"),
            (&test_mm_shrdi_epi32, "test_mm_shrdi_epi32"),
            (&test_mm_mask_shrdi_epi32, "test_mm_mask_shrdi_epi32"),
            (&test_mm_maskz_shrdi_epi32, "test_mm_maskz_shrdi_epi32"),
            (&test_mm_shrdi_epi16, "test_mm_shrdi_epi16"),
            (&test_mm_mask_shrdi_epi16, "test_mm_mask_shrdi_epi16"),
            (&test_mm_maskz_shrdi_epi16, "test_mm_maskz_shrdi_epi16"),
        ]
    }
}

fn test_mm_mask_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi16(5);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[5i16; 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_expandloadu_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi8(7);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[7i8; 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8);
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_expandloadu_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_mask_compressstoreu_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_compressstoreu_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_mask_compress_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_compress_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_compress_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_maskz_compress_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_mask_expand_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_expand_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_expand_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_maskz_expand_epi8() -> Result<(), String> {
    test_mm_mask_expandloadu_epi8()
}
fn test_mm_shldv_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(2, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[2i64, 1i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_shldv_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_maskz_shldv_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_shldv_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[4, 3, 2, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}
fn test_mm_mask_shldv_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_maskz_shldv_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_shldv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_shldv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_shldv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_shrdv_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_mask_shrdv_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_maskz_shrdv_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_shrdv_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_mask_shrdv_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_maskz_shrdv_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_shrdv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_shrdv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_shrdv_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_shldi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_mask_shldi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_maskz_shldi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_shldi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_mask_shldi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_maskz_shldi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_shldi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_shldi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_shldi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_shrdi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_mask_shrdi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_maskz_shrdi_epi64() -> Result<(), String> {
    test_mm_shldv_epi64()
}
fn test_mm_shrdi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_mask_shrdi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_maskz_shrdi_epi32() -> Result<(), String> {
    test_mm_shldv_epi32()
}
fn test_mm_shrdi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_mask_shrdi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
fn test_mm_maskz_shrdi_epi16() -> Result<(), String> {
    test_mm_mask_expandloadu_epi16()
}
