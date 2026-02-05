use std::arch::x86_64::{
    __m128i, _mm_cmpeq_epi16, _mm_cmpeq_epi8, _mm_cmpgt_epi16, _mm_cmpgt_epi32, _mm_cmpgt_epi8, _mm_cmplt_epi16, _mm_cmplt_epi32, _mm_cmplt_epi8, _mm_load_si128, _mm_loadl_epi64,
    _mm_loadu_si128, _mm_packs_epi16, _mm_packs_epi32, _mm_sad_epu8, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set1_epi8, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x,
    _mm_set_epi8, _mm_setr_epi16, _mm_setr_epi32, _mm_setr_epi8, _mm_slli_epi16, _mm_slli_epi32, _mm_slli_epi64, _mm_slli_si128, _mm_srai_epi16, _mm_srai_epi32, _mm_srli_epi16,
    _mm_srli_epi32, _mm_srli_epi64, _mm_srli_si128, _mm_store_si128, _mm_storel_epi64, _mm_storeu_si128,
};

use log::info;
use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_sad_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_sad_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        check_array_equality(&result, &[40, 0, 0, 0, 40, 0, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let a = _mm_set1_epi8(v[0] as i8);
                let b = _mm_set1_epi8(v[1] as i8);
                let _result = _mm_sad_epu8(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_slli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_slli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0, 0, 0, 0, 13, 14, 15, 16, 9, 10, 11, 12, 5, 6, 7, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _result = _mm_slli_si128::<4>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_srli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8, 1, 2, 3, 4, 0, 0, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _result = _mm_srli_si128::<4>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_slli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let result = _mm_slli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_slli_epi16::<2>(_mm_set1_epi16(v[0] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let result = _mm_slli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[8; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_slli_epi32::<3>(_mm_set1_epi32(v[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_slli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let result = _mm_slli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[16; 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_slli_epi64::<4>(_mm_set1_epi64x(v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srai_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let result = _mm_srai_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_srai_epi16::<2>(_mm_set1_epi16(v[0] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srai_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let result = _mm_srai_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[-4; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_srai_epi32::<3>(_mm_set1_epi32(v[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let result = _mm_srli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_srli_epi16::<2>(_mm_set1_epi16(v[0] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let result = _mm_srli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_srli_epi32::<3>(_mm_set1_epi32(v[0]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_srli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let result = _mm_srli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[4; 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_srli_epi64::<4>(_mm_set1_epi64x(v[0] as i64));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpeq_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(42);
        let b = _mm_set1_epi8(42);
        let result = _mm_cmpeq_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[-1; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmpeq_epi8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8(v[1] as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpeq_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(42);
        let b = _mm_set1_epi16(42);
        let result = _mm_cmpeq_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-1; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmpeq_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16(v[1] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_cmpgt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[-1; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmpgt_epi8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8(v[1] as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(50);
        let result = _mm_cmpgt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-1; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmpgt_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16(v[1] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1000);
        let b = _mm_set1_epi32(500);
        let result = _mm_cmpgt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[-1; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmpgt_epi32(_mm_set1_epi32(v[0]), _mm_set1_epi32(v[1]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(5);
        let b = _mm_set1_epi8(10);
        let result = _mm_cmplt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[-1; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmplt_epi8(_mm_set1_epi8(v[0] as i8), _mm_set1_epi8(v[1] as i8));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(50);
        let b = _mm_set1_epi16(100);
        let result = _mm_cmplt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-1; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmplt_epi16(_mm_set1_epi16(v[0] as i16), _mm_set1_epi16(v[1] as i16));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(500);
        let b = _mm_set1_epi32(1000);
        let result = _mm_cmplt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[-1; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<2>();
                let _result = _mm_cmplt_epi32(_mm_set1_epi32(v[0]), _mm_set1_epi32(v[1]));
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<16>();
                let _result = _mm_set_epi8(
                    vals[15] as i8, vals[14] as i8, vals[13] as i8, vals[12] as i8, vals[11] as i8, vals[10] as i8, vals[9] as i8, vals[8] as i8,
                    vals[7] as i8, vals[6] as i8, vals[5] as i8, vals[4] as i8, vals[3] as i8, vals[2] as i8, vals[1] as i8, vals[0] as i8);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let _result = _mm_set_epi16(vals[7] as i16, vals[6] as i16, vals[5] as i16, vals[4] as i16, vals[3] as i16, vals[2] as i16, vals[1] as i16, vals[0] as i16);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi64x(100, 200);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[200, 100])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<2>();
                let _result = _mm_set_epi64x(vals[1] as i64, vals[0] as i64);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi8(42);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[42; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_set1_epi8(v[0] as i8);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi16(42);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[42; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_set1_epi16(v[0] as i16);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi64x(42);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[42; 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let _result = _mm_set1_epi64x(v[0] as i64);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setr_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<16>();
                let _result = _mm_setr_epi8(
                    vals[0] as i8, vals[1] as i8, vals[2] as i8, vals[3] as i8, vals[4] as i8, vals[5] as i8, vals[6] as i8, vals[7] as i8,
                    vals[8] as i8, vals[9] as i8, vals[10] as i8, vals[11] as i8, vals[12] as i8, vals[13] as i8, vals[14] as i8, vals[15] as i8);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setr_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi16(0, 1, 2, 3, 4, 5, 6, 7);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 3, 4, 5, 6, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let _result = _mm_setr_epi16(vals[0] as i16, vals[1] as i16, vals[2] as i16, vals[3] as i16, vals[4] as i16, vals[5] as i16, vals[6] as i16, vals[7] as i16);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_setr_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi32(0, 1, 2, 3);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 1, 2, 3])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_setr_epi32(vals[0], vals[1], vals[2], vals[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadl_epi64() -> Result<(), String> {
    unsafe {
        let data: [i64; 2] = [42, 100];
        let result = _mm_loadl_epi64(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[42, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<2>();
                let data: [i64; 2] = [vals[0] as i64, vals[1] as i64];
                let _result = _mm_loadl_epi64(data.as_ptr() as *const __m128i);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_load_si128() -> Result<(), String> {
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let data = Aligned([1, 2, 3, 4]);
        let result = _mm_load_si128(data.0.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 3, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let data = Aligned([vals[0], vals[1], vals[2], vals[3]]);
                let _result = _mm_load_si128(data.0.as_ptr() as *const __m128i);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_loadu_si128() -> Result<(), String> {
    unsafe {
        let data: [i32; 4] = [10, 20, 30, 40];
        let result = _mm_loadu_si128(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 20, 30, 40])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let _result = _mm_loadu_si128(vals.as_ptr() as *const __m128i);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_store_si128() -> Result<(), String> {
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let mut data = Aligned([0; 4]);
        let vec = _mm_set_epi32(4, 3, 2, 1);
        _mm_store_si128(data.0.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data.0, &data.0)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut data = Aligned([0; 4]);
                let vals = get_random_i32_array::<4>();
                let vec = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                _mm_store_si128(data.0.as_mut_ptr() as *mut __m128i, vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storeu_si128() -> Result<(), String> {
    unsafe {
        let mut data: [i32; 4] = [0; 4];
        let vec = _mm_set_epi32(40, 30, 20, 10);
        _mm_storeu_si128(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut data: [i32; 4] = [0; 4];
                let vals = get_random_i32_array::<4>();
                let vec = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                _mm_storeu_si128(data.as_mut_ptr() as *mut __m128i, vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_storel_epi64() -> Result<(), String> {
    unsafe {
        let mut data: [i64; 2] = [0; 2];
        let vec = _mm_set_epi64x(100, 42);
        _mm_storel_epi64(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut data: [i64; 2] = [0; 2];
                let vals = get_random_i32_array::<2>();
                let vec = _mm_set_epi64x(vals[1] as i64, vals[0] as i64);
                _mm_storel_epi64(data.as_mut_ptr() as *mut __m128i, vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_packs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(200, 150, 100, 50, 10, -10, -50, -100);
        let b = _mm_set_epi16(127, 126, 125, 124, -128, -127, -126, -125);
        let result = _mm_packs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[-100, -50, -10, 10, 50, 100, 127, 127, -125, -126, -127, -128, 124, 125, 126, 127])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(vals[7] as i16, vals[6] as i16, vals[5] as i16, vals[4] as i16, vals[3] as i16, vals[2] as i16, vals[1] as i16, vals[0] as i16);
                let b = _mm_set_epi16(vals[0] as i16, vals[1] as i16, vals[2] as i16, vals[3] as i16, vals[4] as i16, vals[5] as i16, vals[6] as i16, vals[7] as i16);
                let _result = _mm_packs_epi16(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_packs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(40000, 30000, 10, -10);
        let b = _mm_set_epi32(32767, 32766, -32768, -32767);
        let result = _mm_packs_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[-10, 10, 30000, 32767, -32767, -32768, 32766, 32767])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi32(vals[7], vals[6], vals[5], vals[4]);
                let b = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _result = _mm_packs_epi32(a, b);
            }
        }
    }

    Ok(())
}
