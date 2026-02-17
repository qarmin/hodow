use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_and_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_maskz_and_epi64(0b11u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // elementwise AND: [1 & 3, 2 & 4] => [1, 0]
        check_array_equality(&out, &[1i64, 0i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_and_epi64(0b11u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_or_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_or_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // elementwise OR: [1|5, 2|6, 3|7, 4|8] => [5,6,7,12]
        check_array_equality(&out, &[5i32, 6i32, 7i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_or_epi32(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_or_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        // masked (non-zeroring) variant needs src, k, a, b
        let r = _mm_mask_or_epi32(_mm_setzero_si128(), 0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[5i32, 6i32, 7i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_or_epi32(_mm_setzero_si128(), 0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_or_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_maskz_or_epi32(0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[5i32, 6i32, 7i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_or_epi32(0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_or_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_or_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // elementwise OR: [1|3, 2|4] => [3,6]
        check_array_equality(&out, &[3i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_or_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_or_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_mask_or_epi64(_mm_setzero_si128(), 0b11u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_or_epi64(_mm_setzero_si128(), 0b11u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_or_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_maskz_or_epi64(0b11u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_or_epi64(0b11u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_xor_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_xor_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // elementwise XOR: [1^5, 2^6, 3^7, 4^8] => [4,4,4,12]
        check_array_equality(&out, &[4i32, 4i32, 4i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_xor_epi32(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_xor_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_mask_xor_epi32(_mm_setzero_si128(), 0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[4i32, 4i32, 4i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_xor_epi32(_mm_setzero_si128(), 0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_xor_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(8, 7, 6, 5);
        let r = _mm_maskz_xor_epi32(0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[4i32, 4i32, 4i32, 12i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_xor_epi32(0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_xor_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_xor_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        // elementwise XOR: [1^3, 2^4] => [2,6]
        check_array_equality(&out, &[2i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_xor_epi64(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_xor_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_mask_xor_epi64(_mm_setzero_si128(), 0b11u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[2i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_mask_xor_epi64(_mm_setzero_si128(), 0b11u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_xor_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(4, 3);
        let r = _mm_maskz_xor_epi64(0b11u8, a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[2i64, 6i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_maskz_xor_epi64(0b11u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_andnot_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let r = _mm_mask_andnot_epi32(_mm_setzero_si128(), 0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        // (~a) & b -> result: [0x00, 0xFF, 0x00, 0x00]
        check_array_equality(&out, &[0i32, 0xFFi32, 0i32, 0i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_andnot_epi32(_mm_setzero_si128(), 0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_andnot_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let r = _mm_maskz_andnot_epi32(0b1111u8, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0i32, 0xFFi32, 0i32, 0i32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_maskz_andnot_epi32(0b1111u8, a_r, b_r);
            }
        }
    }
    Ok(())
}
