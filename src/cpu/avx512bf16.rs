#![feature(stdarch_x86_avx512_bf16)]

#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, check_float_equality, check_int_equality, get_random_float, get_random_float32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "AVX-512 BF16"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtne2ps_pbh, "test_mm_cvtne2ps_pbh"),
            (&test_mm_mask_cvtne2ps_pbh, "test_mm_mask_cvtne2ps_pbh"),
            (&test_mm_maskz_cvtne2ps_pbh, "test_mm_maskz_cvtne2ps_pbh"),
            (&test_mm_dpbf16_ps, "test_mm_dpbf16_ps"),
            (&test_mm_mask_dpbf16_ps, "test_mm_mask_dpbf16_ps"),
            (&test_mm_maskz_dpbf16_ps, "test_mm_maskz_dpbf16_ps"),
            (&test_mm_cvtpbh_ps, "test_mm_cvtpbh_ps"),
            (&test_mm_mask_cvtpbh_ps, "test_mm_mask_cvtpbh_ps"),
            (&test_mm_maskz_cvtpbh_ps, "test_mm_maskz_cvtpbh_ps"),
            (&test_mm_cvtsbh_ss, "test_mm_cvtsbh_ss"),
            (&test_mm_cvtneps_pbh, "test_mm_cvtneps_pbh"),
            (&test_mm_mask_cvtneps_pbh, "test_mm_mask_cvtneps_pbh"),
            (&test_mm_maskz_cvtneps_pbh, "test_mm_maskz_cvtneps_pbh"),
            (&test_mm_cvtness_sbh, "test_mm_cvtness_sbh"),
        ]
    }
}

pub(super) fn test_mm_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let a_bits: [u16; 8] = [0x3f80, 0x4000, 0x4040, 0x4080, 0x0000, 0x0000, 0x0000, 0x0000];
        let b_bits: [u16; 8] = [0x0000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);

        let result_v = _mm_cvtne2ps_pbh(a, b);
        let result = std::mem::transmute::<__m128bh, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_cvtne2ps_pbh(a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x4080, 0x4040, 0x4000, 0x3f80, 0x0000, 0x0000, 0x0000, 0x0000];
        let b_bits: [u16; 8] = [0x0000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);

        let src: __m128 = _mm_setzero_ps();
        let result_v = _mm_mask_cvtne2ps_pbh(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[4.0, 3.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_mask_cvtne2ps_pbh(src, k, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x3f80, 0x4000, 0x4040, 0x4080, 0x0000, 0x0000, 0x0000, 0x0000];
        let b_bits: [u16; 8] = [0x0000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);

        let result_v = _mm_maskz_cvtne2ps_pbh(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);

        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_maskz_cvtne2ps_pbh(0u8 as __mmask8, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x4000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let result_v = _mm_dpbf16_ps(src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[4.0, 4.0, 4.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_dpbf16_ps(src, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x3f80; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let result_v = _mm_mask_dpbf16_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[2.0, 2.0, 2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_mask_dpbf16_ps(src, k, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let src: __m128 = _mm_setzero_ps();
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x3f80; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let result_v = _mm_maskz_dpbf16_ps(k, src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[2.0, 2.0, 2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_maskz_dpbf16_ps(k, src, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let vals_f32 = [10.0f32, 11.0, 12.0, 13.0];
        let mut a_bits = [0u16; 8];
        for i in 0..4 {
            a_bits[i] = (vals_f32[i].to_bits() >> 16) as u16;
        }
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let result_v = _mm_cvtpbh_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[10.0, 11.0, 12.0, 13.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let _ = _mm_cvtpbh_ps(a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let vals_f32 = [13.0f32, 12.0, 11.0, 10.0];
        let mut a_bits = [0u16; 8];
        for i in 0..4 {
            a_bits[i] = (vals_f32[i].to_bits() >> 16) as u16;
        }
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let src: __m128 = _mm_setzero_ps();
        let result_v = _mm_mask_cvtpbh_ps(src, k, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[13.0, 12.0, 11.0, 10.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let _ = _mm_mask_cvtpbh_ps(_mm_setzero_ps(), k, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let vals_f32 = [1.0f32, 0.0, 1.0, 0.0];
        let mut a_bits = [0u16; 8];
        for i in 0..4 {
            a_bits[i] = (vals_f32[i].to_bits() >> 16) as u16;
        }
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let result_v = _mm_maskz_cvtpbh_ps(k, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[1.0, 0.0, 1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let _ = _mm_maskz_cvtpbh_ps(k, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsbh_ss() -> Result<(), String> {
    unsafe {
        let val = 5.5f32;
        let bf: u16 = (val.to_bits() >> 16) as u16;
        let res = _mm_cvtsbh_ss(std::mem::transmute::<u16, bf16>(bf));
        check_float_array_equality_with_error(&[res], &[5.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<1>()[0];
                let bf_r: u16 = (v.to_bits() >> 16) as u16;
                let _ = _mm_cvtsbh_ss(std::mem::transmute::<u16, bf16>(bf_r));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let a_bits: [u16; 8] = [0x3f00, 0x3f80, 0x4000, 0x4080, 0, 0, 0, 0];
        let b_bits: [u16; 8] = [0x0000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let result_v = _mm_cvtneps_pbh(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[0.5, 1.0, 2.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_cvtneps_pbh(a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x40C0, 0x4080, 0x4040, 0x4000, 0, 0, 0, 0];
        let b_bits: [u16; 8] = [0x0000; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let src: __m128 = _mm_setzero_ps();
        let result_v = _mm_mask_cvtneps_pbh(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[6.0, 4.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_mask_cvtneps_pbh(src, k, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x3f80; 8];
        let a: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits);
        let result_v = _mm_maskz_cvtneps_pbh(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[0.0, 1.0, 0.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let mut a_bits_r = [0u16; 8];
                let mut b_bits_r = [0u16; 8];
                for i in 0..4 {
                    a_bits_r[i] = (arr1[i].to_bits() >> 16) as u16;
                    b_bits_r[i] = (arr2[i].to_bits() >> 16) as u16;
                }
                let a_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(a_bits_r);
                let b_r: __m128bh = std::mem::transmute::<[u16; 8], __m128bh>(b_bits_r);
                let _ = _mm_maskz_cvtneps_pbh(k, a_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtness_sbh() -> Result<(), String> {
    unsafe {
        let val = 9.0f32;
        let res = _mm_cvtness_sbh(val);
        check_int_equality(res.to_bits(), 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float();
                let _ = _mm_cvtness_sbh(v);
            }
        }
    }

    Ok(())
}
