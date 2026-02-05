#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_float_equality, check_int_equality};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::{get_four_random_floats, get_fuzzing, get_random_float, get_random_float64_array};

pub struct SSE2;

impl ExtensionTest for SSE2 {
    fn get_name() -> &'static str {
        "SSE2"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_set_pd, "test_mm_set_pd"),
            (&test_mm_set1_pd, "test_mm_set1_pd"),
            (&test_mm_setzero_pd, "test_mm_setzero_pd"),
            (&test_mm_add_pd, "test_mm_add_pd"),
            (&test_mm_sub_pd, "test_mm_sub_pd"),
            (&test_mm_mul_pd, "test_mm_mul_pd"),
            (&test_mm_load_pd, "test_mm_load_pd"),
            (&test_mm_loadu_pd, "test_mm_loadu_pd"),
            (&test_mm_store_pd, "test_mm_store_pd"),
            (&test_mm_cvtsd_f64, "test_mm_cvtsd_f64"),
            (&test_mm_set_epi32, "test_mm_set_epi32"),
            (&test_mm_set1_epi32, "test_mm_set1_epi32"),
            (&test_mm_setzero_si128, "test_mm_setzero_si128"),
            (&test_mm_add_epi32, "test_mm_add_epi32"),
            (&test_mm_sub_epi32, "test_mm_sub_epi32"),
            (&test_mm_and_si128, "test_mm_and_si128"),
            (&test_mm_or_si128, "test_mm_or_si128"),
            (&test_mm_xor_si128, "test_mm_xor_si128"),
            (&test_mm_cmpeq_epi32, "test_mm_cmpeq_epi32"),
            (&test_mm_cvtsi32_si128, "test_mm_cvtsi32_si128"),
            (&test_mm_cvtsi128_si32, "test_mm_cvtsi128_si32"),
            (&test_mm_pause, "test_mm_pause"),
            (&test_mm_lfence, "test_mm_lfence"),
            (&test_mm_mfence, "test_mm_mfence"),
            (&test_mm_add_epi8, "test_mm_add_epi8"),
            (&test_mm_add_epi16, "test_mm_add_epi16"),
            (&test_mm_add_epi64, "test_mm_add_epi64"),
            (&test_mm_adds_epi8, "test_mm_adds_epi8"),
            (&test_mm_adds_epi16, "test_mm_adds_epi16"),
            (&test_mm_adds_epu8, "test_mm_adds_epu8"),
            (&test_mm_adds_epu16, "test_mm_adds_epu16"),
            (&test_mm_sub_epi16, "test_mm_sub_epi16"),
            (&test_mm_sub_epi64, "test_mm_sub_epi64"),
            (&test_mm_subs_epi16, "test_mm_subs_epi16"),
            (&test_mm_subs_epu8, "test_mm_subs_epu8"),
            (&test_mm_subs_epu16, "test_mm_subs_epu16"),
            (&test_mm_avg_epu8, "test_mm_avg_epu8"),
            (&test_mm_avg_epu16, "test_mm_avg_epu16"),
            (&test_mm_madd_epi16, "test_mm_madd_epi16"),
            (&test_mm_max_epi16, "test_mm_max_epi16"),
            (&test_mm_max_epu8, "test_mm_max_epu8"),
            (&test_mm_min_epi16, "test_mm_min_epi16"),
            (&test_mm_min_epu8, "test_mm_min_epu8"),
            (&test_mm_mulhi_epi16, "test_mm_mulhi_epi16"),
            (&test_mm_mulhi_epu16, "test_mm_mulhi_epu16"),
            (&test_mm_mullo_epi16, "test_mm_mullo_epi16"),
            (&test_mm_mul_epu32, "test_mm_mul_epu32"),
            (&test_mm_sad_epu8, "test_mm_sad_epu8"),
            (&test_mm_slli_si128, "test_mm_slli_si128"),
            (&test_mm_srli_si128, "test_mm_srli_si128"),
            (&test_mm_slli_epi16, "test_mm_slli_epi16"),
            (&test_mm_slli_epi32, "test_mm_slli_epi32"),
            (&test_mm_slli_epi64, "test_mm_slli_epi64"),
            (&test_mm_srai_epi16, "test_mm_srai_epi16"),
            (&test_mm_srai_epi32, "test_mm_srai_epi32"),
            (&test_mm_srli_epi16, "test_mm_srli_epi16"),
            (&test_mm_srli_epi32, "test_mm_srli_epi32"),
            (&test_mm_srli_epi64, "test_mm_srli_epi64"),
            (&test_mm_cmpeq_epi8, "test_mm_cmpeq_epi8"),
            (&test_mm_cmpeq_epi16, "test_mm_cmpeq_epi16"),
            (&test_mm_cmpgt_epi8, "test_mm_cmpgt_epi8"),
            (&test_mm_cmpgt_epi16, "test_mm_cmpgt_epi16"),
            (&test_mm_cmpgt_epi32, "test_mm_cmpgt_epi32"),
            (&test_mm_cmplt_epi8, "test_mm_cmplt_epi8"),
            (&test_mm_cmplt_epi16, "test_mm_cmplt_epi16"),
            (&test_mm_cmplt_epi32, "test_mm_cmplt_epi32"),
            (&test_mm_set_epi8, "test_mm_set_epi8"),
            (&test_mm_set_epi16, "test_mm_set_epi16"),
            (&test_mm_set_epi64x, "test_mm_set_epi64x"),
            (&test_mm_set1_epi8, "test_mm_set1_epi8"),
            (&test_mm_set1_epi16, "test_mm_set1_epi16"),
            (&test_mm_set1_epi64x, "test_mm_set1_epi64x"),
            (&test_mm_setr_epi8, "test_mm_setr_epi8"),
            (&test_mm_setr_epi16, "test_mm_setr_epi16"),
            (&test_mm_setr_epi32, "test_mm_setr_epi32"),
            (&test_mm_loadl_epi64, "test_mm_loadl_epi64"),
            (&test_mm_load_si128, "test_mm_load_si128"),
            (&test_mm_loadu_si128, "test_mm_loadu_si128"),
            (&test_mm_store_si128, "test_mm_store_si128"),
            (&test_mm_storeu_si128, "test_mm_storeu_si128"),
            (&test_mm_storel_epi64, "test_mm_storel_epi64"),
            (&test_mm_packs_epi16, "test_mm_packs_epi16"),
            (&test_mm_packs_epi32, "test_mm_packs_epi32"),
            (&test_mm_packus_epi16, "test_mm_packus_epi16"),
            (&test_mm_unpackhi_epi8, "test_mm_unpackhi_epi8"),
            (&test_mm_unpackhi_epi16, "test_mm_unpackhi_epi16"),
            (&test_mm_unpackhi_epi32, "test_mm_unpackhi_epi32"),
            (&test_mm_unpackhi_epi64, "test_mm_unpackhi_epi64"),
            (&test_mm_unpacklo_epi8, "test_mm_unpacklo_epi8"),
            (&test_mm_unpacklo_epi16, "test_mm_unpacklo_epi16"),
            (&test_mm_unpacklo_epi32, "test_mm_unpacklo_epi32"),
            (&test_mm_unpacklo_epi64, "test_mm_unpacklo_epi64"),
            (&test_mm_shuffle_epi32, "test_mm_shuffle_epi32"),
            (&test_mm_shufflehi_epi16, "test_mm_shufflehi_epi16"),
            (&test_mm_shufflelo_epi16, "test_mm_shufflelo_epi16"),
            (&test_mm_extract_epi16, "test_mm_extract_epi16"),
            (&test_mm_insert_epi16, "test_mm_insert_epi16"),
            (&test_mm_movemask_epi8, "test_mm_movemask_epi8"),
            (&test_mm_cvtepi32_pd, "test_mm_cvtepi32_pd"),
            (&test_mm_cvtepi32_ps, "test_mm_cvtepi32_ps"),
            (&test_mm_cvtpd_epi32, "test_mm_cvtpd_epi32"),
            (&test_mm_cvtps_epi32, "test_mm_cvtps_epi32"),
            (&test_mm_cvttpd_epi32, "test_mm_cvttpd_epi32"),
            (&test_mm_cvttps_epi32, "test_mm_cvttps_epi32"),
            (&test_mm_add_sd, "test_mm_add_sd"),
            (&test_mm_div_sd, "test_mm_div_sd"),
            (&test_mm_div_pd, "test_mm_div_pd"),
            (&test_mm_max_sd, "test_mm_max_sd"),
            (&test_mm_max_pd, "test_mm_max_pd"),
            (&test_mm_min_sd, "test_mm_min_sd"),
            (&test_mm_min_pd, "test_mm_min_pd"),
            (&test_mm_mul_sd, "test_mm_mul_sd"),
            (&test_mm_sqrt_sd, "test_mm_sqrt_sd"),
            (&test_mm_sqrt_pd, "test_mm_sqrt_pd"),
            (&test_mm_sub_sd, "test_mm_sub_sd"),
            (&test_mm_and_pd, "test_mm_and_pd"),
            (&test_mm_andnot_pd, "test_mm_andnot_pd"),
            (&test_mm_or_pd, "test_mm_or_pd"),
            (&test_mm_xor_pd, "test_mm_xor_pd"),
            (&test_mm_andnot_si128, "test_mm_andnot_si128"),
        ]
    }
}

fn test_mm_set_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_random_float() as f64;
                let b = get_random_float() as f64;
                let _result = _mm_set_pd(b, a);
            }
        }
    }

    Ok(())
}

fn test_mm_set1_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_pd(3.13);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[3.13, 3.13])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as f64;
                let _result = _mm_set1_pd(value);
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_pd();
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_add_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[6.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float64_array::<4>();
                let _result = _mm_add_pd(_mm_set_pd(arr[1], arr[0]), _mm_set_pd(arr[3], arr[2]));
            }
        }
    }

    Ok(())
}

fn test_mm_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0, 6.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_sub_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_sub_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(4.0, 5.0);
        let result = _mm_mul_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[15.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a1 = get_random_float() as f64;
                let a2 = get_random_float() as f64;
                let b1 = get_random_float() as f64;
                let b2 = get_random_float() as f64;
                let _result = _mm_mul_pd(_mm_set_pd(a2, a1), _mm_set_pd(b2, b1));
            }
        }
    }

    Ok(())
}

fn test_mm_load_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([15.0, 62.0]);
        let result = _mm_load_pd(data.0.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[15.0, 62.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let result = _mm_load_pd(data.0.as_ptr());
                let _result = std::mem::transmute::<__m128d, [f64; 2]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let result = _mm_loadu_pd(data.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);

        check_float_array_equality_with_error(&result, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = [get_random_float() as f64, get_random_float() as f64];
                let result = _mm_loadu_pd(data.as_ptr());
                let _result = std::mem::transmute::<__m128d, [f64; 2]>(result);
            }
        }
    }

    Ok(())
}

fn test_mm_store_pd() -> Result<(), String> {
    #[repr(align(16))]
    struct AlignedData([f64; 2]);

    unsafe {
        let data = AlignedData([1.0, 2.0]);
        let mut result = AlignedData([0.0; 2]);
        let vec = _mm_loadu_pd(data.0.as_ptr());
        _mm_store_pd(result.0.as_mut_ptr(), vec);
        check_float_array_equality_with_error(&result.0, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let data = AlignedData([get_random_float() as f64, get_random_float() as f64]);
                let mut result = AlignedData([0.0; 2]);
                let vec = _mm_loadu_pd(data.0.as_ptr());
                _mm_store_pd(result.0.as_mut_ptr(), vec);
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsd_f64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let result = _mm_cvtsd_f64(a);
        check_float_array_equality_with_error(&[result], &[2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as f64;
                let vec = _mm_set_pd(get_random_float() as f64, value);
                let result = _mm_cvtsd_f64(vec);
                check_float_equality(result as f32, value as f32, 0.001)?;
            }
        }
    }

    Ok(())
}

fn test_mm_set_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi32(1, 2, 3, 4);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [4, 3, 2, 1];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let values = [get_random_float() as i32, get_random_float() as i32, get_random_float() as i32, get_random_float() as i32];
                let result = _mm_set_epi32(values[3], values[2], values[1], values[0]);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                check_array_equality(&result, &values)?;
            }
        }
    }

    Ok(())
}

fn test_mm_set1_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi32(42);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [42, 42, 42, 42];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let result = _mm_set1_epi32(value);
                let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
                let expected = [value, value, value, value];
                check_array_equality(&result, &expected)?;
            }
        }
    }

    Ok(())
}

fn test_mm_setzero_si128() -> Result<(), String> {
    unsafe {
        let result = _mm_setzero_si128();
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 0, 0, 0];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_add_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [12, 10, 8, 6];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_add_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_sub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [32, 23, 14, 5];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_sub_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_and_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_and_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0x00, 0x00, 0x00, 0xFF];
        check_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_and_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_or_si128() -> Result<(), String> {
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
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_or_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_xor_si128() -> Result<(), String> {
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
                let a = get_four_random_floats().map(|x| x as i32);
                let b = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_xor_si128(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(b[3], b[2], b[1], b[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_cmpeq_epi32() -> Result<(), String> {
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
                let a = get_four_random_floats().map(|x| x as i32);
                let _result = _mm_cmpeq_epi32(_mm_set_epi32(a[3], a[2], a[1], a[0]), _mm_set_epi32(a[3], a[2], a[1], a[0]));
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsi32_si128() -> Result<(), String> {
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

fn test_mm_cvtsi128_si32() -> Result<(), String> {
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

fn test_mm_pause() -> Result<(), String> {
    _mm_pause();
    Ok(())
}

fn test_mm_lfence() -> Result<(), String> {
    // unsafe {
    //     _mm_lfence();
    // }
    Ok(())
}

fn test_mm_mfence() -> Result<(), String> {
    // unsafe {
    //     _mm_mfence();
    // }
    Ok(())
}

fn test_mm_add_epi8() -> Result<(), String> {
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

fn test_mm_add_epi16() -> Result<(), String> {
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

fn test_mm_add_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(50, 75);
        let result = _mm_add_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[275, 150])?;
    }
    Ok(())
}

fn test_mm_adds_epi8() -> Result<(), String> {
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

fn test_mm_adds_epi16() -> Result<(), String> {
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

fn test_mm_adds_epu8() -> Result<(), String> {
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

fn test_mm_adds_epu16() -> Result<(), String> {
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

fn test_mm_subs_epi8() -> Result<(), String> {
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

fn test_mm_sub_epi16() -> Result<(), String> {
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

fn test_mm_sub_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(30, 50);
        let result = _mm_sub_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[150, 70])?;
    }
    Ok(())
}

fn test_mm_subs_epi16() -> Result<(), String> {
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

fn test_mm_subs_epu8() -> Result<(), String> {
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

fn test_mm_subs_epu16() -> Result<(), String> {
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

fn test_mm_avg_epu8() -> Result<(), String> {
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

fn test_mm_avg_epu16() -> Result<(), String> {
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

fn test_mm_madd_epi16() -> Result<(), String> {
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

fn test_mm_max_epi16() -> Result<(), String> {
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

fn test_mm_max_epu8() -> Result<(), String> {
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

fn test_mm_min_epi16() -> Result<(), String> {
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

fn test_mm_min_epu8() -> Result<(), String> {
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

fn test_mm_mulhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

fn test_mm_mulhi_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1000);
        let b = _mm_set1_epi16(100);
        let result = _mm_mulhi_epu16(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }
    Ok(())
}

fn test_mm_mullo_epi16() -> Result<(), String> {
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

fn test_mm_mul_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 100, 0, 200);
        let b = _mm_set_epi32(0, 5, 0, 3);
        let result = _mm_mul_epu32(a, b);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);

        check_array_equality(&result, &[600, 500])?;
    }
    Ok(())
}

fn test_mm_sad_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_sad_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        check_array_equality(&result, &[40, 0, 0, 0, 40, 0, 0, 0])?;
    }
    Ok(())
}

fn test_mm_slli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_slli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[0, 0, 0, 0, 13, 14, 15, 16, 9, 10, 11, 12, 5, 6, 7, 8])?;
    }
    Ok(())
}

fn test_mm_srli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_srli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8, 1, 2, 3, 4, 0, 0, 0, 0])?;
    }
    Ok(())
}

fn test_mm_slli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let result = _mm_slli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let result = _mm_slli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [8; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_slli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let result = _mm_slli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [16; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srai_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let result = _mm_srai_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srai_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let result = _mm_srai_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let result = _mm_srli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let result = _mm_srli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let result = _mm_srli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [4; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmpeq_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(42);
        let b = _mm_set1_epi8(42);
        let result = _mm_cmpeq_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmpeq_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(42);
        let b = _mm_set1_epi16(42);
        let result = _mm_cmpeq_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmpgt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_cmpgt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmpgt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(50);
        let result = _mm_cmpgt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmpgt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1000);
        let b = _mm_set1_epi32(500);
        let result = _mm_cmpgt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmplt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(5);
        let b = _mm_set1_epi8(10);
        let result = _mm_cmplt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmplt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(50);
        let b = _mm_set1_epi16(100);
        let result = _mm_cmplt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cmplt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(500);
        let b = _mm_set1_epi32(1000);
        let result = _mm_cmplt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_set_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_set_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_set_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi64x(100, 200);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[200, 100])?;
    }
    Ok(())
}

fn test_mm_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi8(42);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [42; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi16(42);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [42; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi64x(42);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [42; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_setr_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_setr_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi16(0, 1, 2, 3, 4, 5, 6, 7);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_setr_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi32(0, 1, 2, 3);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 1, 2, 3];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_loadl_epi64() -> Result<(), String> {
    unsafe {
        let data: [i64; 2] = [42, 100];
        let result = _mm_loadl_epi64(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[42, 0])?;
    }
    Ok(())
}

fn test_mm_load_si128() -> Result<(), String> {
    // Ensure the data is 16-byte aligned so we can safely use _mm_load_si128
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let data = Aligned([1, 2, 3, 4]);
        let result = _mm_load_si128(data.0.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 3, 4])?;
    }
    Ok(())
}

fn test_mm_loadu_si128() -> Result<(), String> {
    unsafe {
        let data: [i32; 4] = [10, 20, 30, 40];
        let result = _mm_loadu_si128(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 20, 30, 40])?;
    }
    Ok(())
}

fn test_mm_store_si128() -> Result<(), String> {
    // Ensure the destination is 16-byte aligned so _mm_store_si128 is valid
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let mut data = Aligned([0; 4]);
        let vec = _mm_set_epi32(4, 3, 2, 1);
        _mm_store_si128(data.0.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data.0, &data.0)?;
    }
    Ok(())
}

fn test_mm_storeu_si128() -> Result<(), String> {
    unsafe {
        let mut data: [i32; 4] = [0; 4];
        let vec = _mm_set_epi32(40, 30, 20, 10);
        _mm_storeu_si128(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }
    Ok(())
}

fn test_mm_storel_epi64() -> Result<(), String> {
    unsafe {
        let mut data: [i64; 2] = [0; 2];
        let vec = _mm_set_epi64x(100, 42);
        _mm_storel_epi64(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }
    Ok(())
}

fn test_mm_packs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(200, 150, 100, 50, 10, -10, -50, -100);
        let b = _mm_set_epi16(127, 126, 125, 124, -128, -127, -126, -125);
        let result = _mm_packs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[-100, -50, -10, 10, 50, 100, 127, 127, -125, -126, -127, -128, 124, 125, 126, 127])?;
    }
    Ok(())
}

fn test_mm_packs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(40000, 30000, 10, -10);
        let b = _mm_set_epi32(32767, 32766, -32768, -32767);
        let result = _mm_packs_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[-10, 10, 30000, 32767, -32767, -32768, 32766, 32767])?;
    }
    Ok(())
}

fn test_mm_packus_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(300, 200, 100, 50, 10, 5, 2, 1);
        let b = _mm_set_epi16(255, 254, 253, 252, -1, -2, -3, -4);
        let result = _mm_packus_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[1, 2, 5, 10, 50, 100, 200, 255, 0, 0, 0, 0, 252, 253, 254, 255])?;
    }
    Ok(())
}

fn test_mm_unpackhi_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpackhi_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31])?;
    }
    Ok(())
}

fn test_mm_unpackhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpackhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[4, 12, 5, 13, 6, 14, 7, 15])?;
    }
    Ok(())
}

fn test_mm_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpackhi_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[2, 6, 3, 7])?;
    }
    Ok(())
}

fn test_mm_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpackhi_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);

        check_array_equality(&result, &[1, 3])?;
    }
    Ok(())
}

fn test_mm_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpacklo_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23])?;
    }
    Ok(())
}

fn test_mm_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpacklo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[0, 8, 1, 9, 2, 10, 3, 11])?;
    }
    Ok(())
}

fn test_mm_unpacklo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpacklo_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[0, 4, 1, 5])?;
    }
    Ok(())
}

fn test_mm_unpacklo_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpacklo_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);

        check_array_equality(&result, &[0, 2])?;
    }
    Ok(())
}

fn test_mm_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_shuffle_epi32::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[3, 2, 1, 0])?;
    }
    Ok(())
}

fn test_mm_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflehi_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[0, 1, 2, 3, 7, 6, 5, 4])?;
    }
    Ok(())
}

fn test_mm_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflelo_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[3, 2, 1, 0, 4, 5, 6, 7])?;
    }
    Ok(())
}

fn test_mm_extract_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_extract_epi16::<3>(a);
        check_int_equality(result, 3)?;
    }
    Ok(())
}

fn test_mm_insert_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_insert_epi16::<3>(a, 99);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 99, 4, 5, 6, 7])?;
    }
    Ok(())
}

fn test_mm_movemask_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        let result = _mm_movemask_epi8(a);

        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 20, 10);
        let result = _mm_cvtepi32_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[10.0, 20.0])?;
    }
    Ok(())
}

fn test_mm_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_cvtepi32_ps(a);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &result)?;
    }
    Ok(())
}

fn test_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[10, 21, 0, 0])?;
    }
    Ok(())
}

fn test_mm_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;
    }
    Ok(())
}

fn test_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.9, 10.9);
        let result = _mm_cvttpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[10, 20, 0, 0])?;
    }
    Ok(())
}

fn test_mm_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvttps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[1, 2, 0, 0])?;
    }
    Ok(())
}

fn test_mm_add_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_add_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_div_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(20.0);
        let b = _mm_set_sd(4.0);
        let result = _mm_div_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.0, 10.0);
        let b = _mm_set_pd(4.0, 2.0);
        let result = _mm_div_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 5.0])?;
    }
    Ok(())
}

fn test_mm_max_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_max_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_max_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[7.0, 10.0])?;
    }
    Ok(())
}

fn test_mm_min_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_min_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_min_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 8.0])?;
    }
    Ok(())
}

fn test_mm_mul_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_mul_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_sqrt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(25.0);
        let b = _mm_set_sd(0.0);
        let result = _mm_sqrt_sd(b, a);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

fn test_mm_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(16.0, 25.0);
        let result = _mm_sqrt_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 4.0])?;
    }
    Ok(())
}

fn test_mm_sub_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(3.0);
        let result = _mm_sub_sd(a, b);
        let expected = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[expected], &[expected])?;
    }
    Ok(())
}

fn test_mm_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_and_pd(a, b);
    }
    Ok(())
}

fn test_mm_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_andnot_pd(a, b);
    }
    Ok(())
}

fn test_mm_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_or_pd(a, b);
    }
    Ok(())
}

fn test_mm_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_xor_pd(a, b);
    }
    Ok(())
}

fn test_mm_andnot_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_andnot_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[0, 255, 0, 0])?;
    }
    Ok(())
}

fn test_mm_bslli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bslli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_bsrli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bsrli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_sll_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_sll_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_sll_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_sll_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [8; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_sll_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(0, 4);
        let result = _mm_sll_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [16; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_sra_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_sra_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_sra_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_sra_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srl_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_srl_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srl_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_srl_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_srl_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let count = _mm_set_epi64x(0, 4);
        let result = _mm_srl_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [4; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_cvtsi32_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = 42i32;
        let result = _mm_cvtsi32_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_maskmoveu_si128() -> Result<(), String> {
    unsafe {
        let mut mem: [i8; 16] = [0; 16];
        let a = _mm_set1_epi8(42);
        let mask = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        _mm_maskmoveu_si128(a, mask, mem.as_mut_ptr());
    }
    Ok(())
}

fn test_mm_stream_si128() -> Result<(), String> {
    unsafe {
        let mut mem: [__m128i; 1] = [_mm_setzero_si128()];
        let a = _mm_set_epi32(4, 3, 2, 1);
        _mm_stream_si128(mem.as_mut_ptr(), a);
    }
    Ok(())
}

fn test_mm_stream_si32() -> Result<(), String> {
    unsafe {
        let mut mem: i32 = 0;
        _mm_stream_si32(&mut mem, 42);
        if mem != 42 {
            return Err(format!("Expected 42, got {}", mem));
        }
    }
    Ok(())
}

fn test_mm_move_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 42);
        let result = _mm_move_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpeq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpeq_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmplt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmplt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmple_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmple_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpgt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpgt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpge_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpge_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpord_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpord_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpunord_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, f64::NAN);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpunord_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpneq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpneq_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnlt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpnlt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnle_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 2.0);
        let b = _mm_set_pd(3.0, 1.0);
        let result = _mm_cmpnle_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpngt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpngt_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnge_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(3.0, 2.0);
        let result = _mm_cmpnge_sd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpeq_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let result = _mm_cmpeq_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmplt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmplt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmple_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let result = _mm_cmple_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpgt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpgt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpge_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpge_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpord_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_cmpord_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpunord_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(f64::NAN, f64::NAN);
        let b = _mm_set_pd(1.0, 2.0);
        let result = _mm_cmpunord_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpneq_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_cmpneq_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnlt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set_pd(1.0, 2.0);
        let result = _mm_cmpnlt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(3.0, 3.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpnle_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpngt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(2.0, 3.0);
        let result = _mm_cmpngt_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_cmpnge_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 1.0);
        let b = _mm_set_pd(2.0, 2.0);
        let result = _mm_cmpnge_pd(a, b);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

fn test_mm_comieq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comieq_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_comilt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comilt_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_comile_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comile_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_comigt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_comigt_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_comige_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comige_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_comineq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_comineq_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomieq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomieq_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomilt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomilt_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomile_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomile_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomigt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let result = _mm_ucomigt_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomige_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomige_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_ucomineq_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let result = _mm_ucomineq_sd(a, b);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_cvtpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let _result = _mm_cvtpd_ps(a);
    }
    Ok(())
}

fn test_mm_cvtps_pd() -> Result<(), String> {
    unsafe {
        let ints = _mm_set_epi32(0, 0, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(ints);
        let result = _mm_cvtps_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
        Ok(())
    }
}

fn test_mm_cvtsd_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(42.7);
        let result = _mm_cvtsd_si32(a);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0, 0, 0, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let b = _mm_set_sd(42.5);
        let result = _mm_cvtsd_ss(a, b);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &result)?;

        Ok(())
    }
}

fn test_mm_cvtss_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b_int = _mm_set_epi32(0, 0, 0, 0x422a0000);
        let b = _mm_castsi128_ps(b_int);
        let result = _mm_cvtss_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);

        check_float_array_equality_with_error(&result, &[0.0])?;
        Ok(())
    }
}

fn test_mm_cvttsd_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(42.9);
        let result = _mm_cvttsd_si32(a);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_set_sd() -> Result<(), String> {
    unsafe {
        let result = _mm_set_sd(42.5);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_set_pd1() -> Result<(), String> {
    unsafe {
        let result = _mm_set_pd1(42.5);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0])?;
    }
    Ok(())
}

fn test_mm_setr_pd() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_pd(1.0, 2.0);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_movemask_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(-1.0, 1.0);
        let result = _mm_movemask_pd(a);
        check_int_equality(result, 0)?;
    }
    Ok(())
}

fn test_mm_load_sd() -> Result<(), String> {
    unsafe {
        let mem = [42.5f64, 1.0];
        let result = _mm_load_sd(mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_loadh_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 1.0);
        let mem = [42.5f64];
        let result = _mm_loadh_pd(a, mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_loadl_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 0.0);
        let mem = [42.5f64];
        let result = _mm_loadl_pd(a, mem.as_ptr());
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_stream_pd() -> Result<(), String> {
    unsafe {
        let mut mem = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_stream_pd(mem.as_mut_ptr(), a);
    }
    Ok(())
}

fn test_mm_store_sd() -> Result<(), String> {
    unsafe {
        let mut mem = [20.0f64];
        let a = _mm_set_sd(42.5);
        _mm_store_sd(mem.as_mut_ptr(), a);
        check_float_array_equality_with_error(&mem, &[20.0])?;
    }
    Ok(())
}

fn test_mm_storeu_pd() -> Result<(), String> {
    unsafe {
        let mut mem = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_storeu_pd(mem.as_mut_ptr(), a);
    }
    Ok(())
}

fn test_mm_storeu_si16() -> Result<(), String> {
    unsafe {
        let mut mem: i16 = 0;
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 42);
        _mm_storeu_si16(&mut mem as *mut i16 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }
    Ok(())
}

fn test_mm_storeu_si32() -> Result<(), String> {
    unsafe {
        let mut mem: i32 = 0;
        let a = _mm_set_epi32(0, 0, 0, 42);
        _mm_storeu_si32(&mut mem as *mut i32 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }
    Ok(())
}

fn test_mm_storeu_si64() -> Result<(), String> {
    unsafe {
        let mut mem: i64 = 0;
        let a = _mm_set_epi64x(0, 42);
        _mm_storeu_si64(&mut mem as *mut i64 as *mut u8, a);
        check_int_equality(mem, 0)?;
    }
    Ok(())
}

fn test_mm_shuffle_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_shuffle_pd::<0b10>(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_move_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_move_sd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_castpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let _result = _mm_castpd_ps(a);
    }
    Ok(())
}

fn test_mm_castpd_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let _result = _mm_castpd_si128(a);
    }
    Ok(())
}

fn test_mm_castps_pd() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0x40800000, 0x40400000, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let result = _mm_castps_pd(a);
        let result = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let _ = result;
        Ok(())
    }
}

fn test_mm_castps_si128() -> Result<(), String> {
    unsafe {
        let a_int = _mm_set_epi32(0x40800000, 0x40400000, 0x40000000, 0x3f800000);
        let a = _mm_castsi128_ps(a_int);
        let result = _mm_castps_si128(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        let expected = [0x3f800000, 0x40000000, 0x40400000, 0x40800000];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_castsi128_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let _result = _mm_castsi128_pd(a);
    }
    Ok(())
}

fn test_mm_castsi128_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let _result = _mm_castsi128_ps(a);
    }
    Ok(())
}

fn test_mm_undefined_pd() -> Result<(), String> {
    unsafe {
        let _result = _mm_undefined_pd();
    }
    Ok(())
}

fn test_mm_undefined_si128() -> Result<(), String> {
    unsafe {
        let _result = _mm_undefined_si128();
    }
    Ok(())
}

fn test_mm_unpackhi_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_unpackhi_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[0.0])?;
    }
    Ok(())
}

fn test_mm_unpacklo_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(4.0, 3.0);
        let result = _mm_unpacklo_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[0.0])?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sse2() {
        let tests = SSE2::get_tests();
        for (fun, name) in tests {
            println!("Running test {}", name);
            fun().unwrap();
        }
    }
}
