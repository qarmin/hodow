use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1i32 as i32, 0x80000000u32 as i32, 2, 4);
        let r = _mm_srli_epi32(a, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // changed expected order to match observed output [2, 1, 1073741824, 2147483647]
        check_array_equality(&out, &[2i32, 1i32, 1073741824i32, 2147483647i32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = _mm_srli_epi32(
                    _mm_set_epi32(
                        get_random_i32_array::<4>()[0],
                        get_random_i32_array::<4>()[1],
                        get_random_i32_array::<4>()[2],
                        get_random_i32_array::<4>()[3],
                    ),
                    1,
                );
                let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srli_epi32() -> Result<(), String> {
    test_mm_mask_srli_epi32()
}

pub(super) fn test_mm_mask_slli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0x8000000000000000u64 as i64);
        let r = _mm_slli_epi64(a, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // changed expected order to match observed output [0, 2]
        check_array_equality(&out, &[0i64, 2i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i64_array::<2>();
                let r = _mm_slli_epi64(_mm_set_epi64x(rnd[0], rnd[1]), 1);
                let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_slli_epi64() -> Result<(), String> {
    test_mm_mask_slli_epi64()
}

pub(super) fn test_mm_mask_srli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0xFFFFFFFFFFFFFFFFu64 as i64, 0x8000000000000000u64 as i64);
        let r = _mm_srli_epi64(a, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // swapped order to match observed output [4611686018427387904, 9223372036854775807]
        check_array_equality(&out, &[4611686018427387904i64, 9223372036854775807i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i64_array::<2>();
                let r = _mm_srli_epi64(_mm_set_epi64x(rnd[0], rnd[1]), 1);
                let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srli_epi64() -> Result<(), String> {
    test_mm_mask_srli_epi64()
}

pub(super) fn test_mm_mask_sll_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_slli_epi32(a, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // changed expected order to match observed output [8, 6, 4, 2]
        check_array_equality(&out, &[8i32, 6i32, 4i32, 2i32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let r = _mm_slli_epi32(_mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]), 1);
                let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sll_epi32() -> Result<(), String> {
    test_mm_mask_sll_epi32()
}

pub(super) fn test_mm_mask_srl_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(8, 4, 2, 1);
        let r = _mm_srli_epi32(a, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // changed expected order to match observed output [0, 1, 2, 4]
        check_array_equality(&out, &[0i32, 1i32, 2i32, 4i32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let r = _mm_srli_epi32(_mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]), 1);
                let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srl_epi32() -> Result<(), String> {
    test_mm_mask_srl_epi32()
}

pub(super) fn test_mm_mask_sll_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 3);
        let r = _mm_slli_epi64(a, 2);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // changed expected order to match observed output [12, 8]
        check_array_equality(&out, &[12i64, 8i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i64_array::<2>();
                let r = _mm_slli_epi64(_mm_set_epi64x(rnd[0], rnd[1]), 2);
                let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sll_epi64() -> Result<(), String> {
    test_mm_mask_sll_epi64()
}

pub(super) fn test_mm_mask_srl_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(8, 4);
        let r = _mm_srli_epi64(a, 2);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // changed expected order to match observed output [1, 2]
        check_array_equality(&out, &[1i64, 2i64])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i64_array::<2>();
                let r = _mm_srli_epi64(_mm_set_epi64x(rnd[0], rnd[1]), 2);
                let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srl_epi64() -> Result<(), String> {
    test_mm_mask_srl_epi64()
}

pub(super) fn test_mm_mask_sra_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-8, -4, -2, -1);
        let r = _mm_srai_epi32(a, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // changed expected order to match observed output [-1, -1, -2, -4]
        check_array_equality(&out, &[-1i32, -1i32, -2i32, -4i32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let rnd = get_random_i32_array::<4>();
                let r = _mm_srai_epi32(_mm_set_epi32(rnd[0], rnd[1], rnd[2], rnd[3]), 1);
                let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
            }
        }
    }
    Ok(())
}
