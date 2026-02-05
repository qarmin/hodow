use std::arch::x86_64::{
    __m128i, _mm_add_epi16, _mm_add_epi64, _mm_add_epi8, _mm_adds_epi16, _mm_adds_epi8, _mm_adds_epu16, _mm_adds_epu8, _mm_avg_epu16, _mm_avg_epu8, _mm_cmpeq_epi32,
    _mm_cvtsi128_si32, _mm_cvtsi32_si128, _mm_madd_epi16, _mm_max_epi16, _mm_max_epu8, _mm_min_epi16, _mm_min_epu8, _mm_mul_epu32, _mm_mulhi_epi16, _mm_mulhi_epu16,
    _mm_mullo_epi16, _mm_or_si128, _mm_pause, _mm_set1_epi16, _mm_set1_epi8, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x, _mm_set_epi8, _mm_sub_epi16, _mm_sub_epi64,
    _mm_sub_epi8, _mm_subs_epi16, _mm_subs_epu16, _mm_subs_epu8, _mm_xor_si128,
};

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality, get_random_float, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_or_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0x00, 0x00, 0x00);
        let b = _mm_set_epi32(0x00, 0xFF, 0x00, 0x00);
        let result = _mm_or_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0x00, 0x00, 0xFF, 0xFF];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_i32_array::<4>();
                let b = get_random_i32_array::<4>();
                let _result = _mm_or_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_xor_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_xor_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0x00, 0xFF, 0xFF, 0x00];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_i32_array::<4>();
                let b = get_random_i32_array::<4>();
                let _result = _mm_xor_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpeq_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(1, 2, 3, 4);
        let result = _mm_cmpeq_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1, -1, -1, -1];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_i32_array::<4>();
                let _result = _mm_cmpeq_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsi32_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi32_si128(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [42, 0, 0, 0];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_cvtsi32_si128(value);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsi128_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 42);
        let result = _mm_cvtsi128_si32(a);
        check_int_equality(result, 42)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let vec = _mm_set_epi32(get_random_float() as i32, get_random_float() as i32, get_random_float() as i32, value);
                let result = _mm_cvtsi128_si32(vec);
                check_int_equality(result, value)?;
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_pause() -> Result<(), String> {
    _mm_pause();
    Ok(())
}

pub(super) fn test_mm_lfence() -> Result<(), String> {
    // unsafe {
    //     _mm_lfence();
    // }
    Ok(())
}

pub(super) fn test_mm_mfence() -> Result<(), String> {
    // unsafe {
    //     _mm_mfence();
    // }
    Ok(())
}

pub(super) fn test_mm_add_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [17; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_add_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [9; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_add_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(50, 75);
        let result = _mm_add_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[275, 150])?;
    }
    Ok(())
}

pub(super) fn test_mm_adds_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100);
        let b = _mm_set1_epi8(50);
        let result = _mm_adds_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        let expected = [127_i8; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_adds_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_adds_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        let expected = [32767_i16; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_adds_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(-56_i8);
        let b = _mm_set1_epi8(-56_i8);
        let result = _mm_adds_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        let expected = [255_u8; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_adds_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-5536_i16);
        let b = _mm_set1_epi16(10000_i16);
        let result = _mm_adds_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        let expected = [65535_u16; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_subs_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(20);
        let b = _mm_set1_epi8(10);
        let result = _mm_sub_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [10; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_sub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(30);
        let result = _mm_sub_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [70; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_sub_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(30, 50);
        let result = _mm_sub_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[150, 70])?;
    }
    Ok(())
}

pub(super) fn test_mm_subs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_subs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        let expected = [-32768_i16; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_subs_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(20);
        let result = _mm_subs_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        let expected = [0_u8; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_subs_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(200);
        let result = _mm_subs_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        let expected = [0_u16; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_avg_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100_i8);
        let b = _mm_set1_epi8(50_i8);
        let result = _mm_avg_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        let expected = [75_u8; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_avg_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(500);
        let result = _mm_avg_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        let expected = [750_u16; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_madd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_madd_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        let expected = [22, 38, 38, 22];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_max_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_max_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        let expected = [80, 70, 60, 50, 40, 30, 20, 10];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_max_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_max_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let expected = [16, 15, 14, 13, 12, 11, 10, 9, 9, 10, 11, 12, 13, 14, 15, 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_min_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_min_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [8, 7, 6, 5, 4, 3, 2, 1];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_min_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_min_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let expected = [1, 2, 3, 4, 5, 6, 7, 8, 8, 7, 6, 5, 4, 3, 2, 1];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_mulhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm_mulhi_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

pub(super) fn test_mm_mullo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(10);
        let b = _mm_set1_epi16(5);
        let result = _mm_mullo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [50; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_mul_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 100, 0, 200);
        let b = _mm_set_epi32(0, 5, 0, 3);
        let result = _mm_mul_epu32(a, b);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);

        check_array_equality(&result, &[600, 500])?;
    }
    Ok(())
}
