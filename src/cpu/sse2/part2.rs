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
        let a = _mm_set_epi32(111, 0, 0, 0);
        let b = _mm_set_epi32(0, 111, 0, 0);
        let result = _mm_or_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 0, 111, 111])?;
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
        let a = _mm_set_epi32(111, 111, 0, 0);
        let b = _mm_set_epi32(111, 0, 111, 0);
        let result = _mm_xor_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 111, 111, 0])?;
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
        check_array_equality(&result, &[-1, -1, -1, -1])?;
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
        check_array_equality(&result, &[42, 0, 0, 0])?;
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
    Ok(())
}

pub(super) fn test_mm_mfence() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_add_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[17; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_add_epi8(
                    _mm_set_epi8(
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
                    ),
                    _mm_set_epi8(
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
                    ),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_add_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[9; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_add_epi16(
                    _mm_set_epi16(
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                    ),
                    _mm_set_epi16(
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                    ),
                );
            }
        }
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

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi64x(vals[0] as i64, vals[1] as i64);
                let b = _mm_set_epi64x(vals[2] as i64, vals[3] as i64);
                let _result = _mm_add_epi64(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_adds_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100);
        let b = _mm_set1_epi8(50);
        let result = _mm_adds_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[127; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_adds_epi8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8((v[0] as i8).wrapping_neg()));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_adds_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_adds_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[32767; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_adds_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_neg()));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_adds_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(-56);
        let b = _mm_set1_epi8(-56);
        let result = _mm_adds_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[111; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_adds_epu8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8((v[0] as i8).wrapping_neg()));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_adds_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-5536);
        let b = _mm_set1_epi16(10000);
        let result = _mm_adds_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        check_array_equality(&result, &[6555; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_adds_epu16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_neg()));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_subs_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(20);
        let b = _mm_set1_epi8(10);
        let result = _mm_sub_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[10; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_sub_epi8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8((v[0] as i8).wrapping_abs() as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(30);
        let result = _mm_sub_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[70; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_sub_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs() as i16));
            }
        }
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

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi64x(vals[0] as i64, vals[1] as i64);
                let b = _mm_set_epi64x(vals[2] as i64, vals[3] as i64);
                let _result = _mm_sub_epi64(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_subs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-30000);
        let b = _mm_set1_epi16(5000);
        let result = _mm_subs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-32768; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_subs_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs() as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_subs_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(20);
        let result = _mm_subs_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_subs_epu8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8((v[0] as i8).wrapping_abs() as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_subs_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(200);
        let result = _mm_subs_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        check_array_equality(&result, &[0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_subs_epu16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs() as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_avg_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(100);
        let b = _mm_set1_epi8(50);
        let result = _mm_avg_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[75; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_avg_epu8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8((v[0] as i8).wrapping_abs() as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_avg_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(500);
        let result = _mm_avg_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        check_array_equality(&result, &[750; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_avg_epu16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs() as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_madd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_madd_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[22, 38, 38, 22])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_madd_epi16(
                    _mm_set_epi16(
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                    ),
                    _mm_set_epi16(
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                    ),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_max_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[80, 70, 60, 50, 40, 30, 20, 10])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_max_epi16(
                    _mm_set_epi16(
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                    ),
                    _mm_set_epi16(
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                    ),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_max_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_max_epu8(
                    _mm_set_epi8(
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
                    ),
                    _mm_set_epi8(
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
                    ),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 20, 3, 40, 5, 60, 7, 80);
        let b = _mm_set_epi16(10, 2, 30, 4, 50, 6, 70, 8);
        let result = _mm_min_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_min_epi16(
                    _mm_set_epi16(
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                        vals[3] as i16,
                        vals[2] as i16,
                        vals[1] as i16,
                        vals[0] as i16,
                    ),
                    _mm_set_epi16(
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                        vals[0] as i16,
                        vals[1] as i16,
                        vals[2] as i16,
                        vals[3] as i16,
                    ),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm_min_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_min_epu8(
                    _mm_set_epi8(
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
                    ),
                    _mm_set_epi8(
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
                    ),
                );
            }
        }
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

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_mulhi_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs()));
            }
        }
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

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_mulhi_epu16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs()));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mullo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(10);
        let b = _mm_set1_epi16(5);
        let result = _mm_mullo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[50; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_mullo_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16((v[0] as i16).wrapping_abs()));
            }
        }
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

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_mul_epu32(_mm_set_epi32(vals[3], vals[2], vals[1], vals[0]), _mm_set_epi32(vals[0], vals[1], vals[2], vals[3]));
            }
        }
    }

    Ok(())
}
