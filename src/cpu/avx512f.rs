#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float, get_random_float32_array, get_random_float64_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;
pub struct AVX512F;

impl ExtensionTest for AVX512F {
    fn get_name() -> &'static str {
        "AVX-512F"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm512_add_ps, "test_mm512_add_ps"),
            (&test_mm512_sub_ps, "test_mm512_sub_ps"),
            (&test_mm512_mul_ps, "test_mm512_mul_ps"),
            (&test_mm512_div_ps, "test_mm512_div_ps"),
            (&test_mm512_add_pd, "test_mm512_add_pd"),
            (&test_mm512_sub_pd, "test_mm512_sub_pd"),
            (&test_mm512_mul_pd, "test_mm512_mul_pd"),
            (&test_mm512_div_pd, "test_mm512_div_pd"),
            (&test_mm512_max_ps, "test_mm512_max_ps"),
            (&test_mm512_min_ps, "test_mm512_min_ps"),
            (&test_mm512_sqrt_ps, "test_mm512_sqrt_ps"),
            (&test_mm512_set1_ps, "test_mm512_set1_ps"),
            (&test_mm512_setzero_ps, "test_mm512_setzero_ps"),
        ]
    }
}

fn test_mm512_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_add_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[17.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_add_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(10.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_sub_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[7.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_sub_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(2.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_mul_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[6.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_mul_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_div_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_ps(12.0);
        let b = _mm512_set1_ps(3.0);
        let result = _mm512_div_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[4.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_div_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(5.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_add_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[8.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_add_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(10.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_sub_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[7.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_sub_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(2.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_mul_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[6.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_mul_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm512_set1_pd(12.0);
        let b = _mm512_set1_pd(3.0);
        let result = _mm512_div_pd(a, b);
        let result = std::mem::transmute::<__m512d, [f64; 8]>(result);
        check_float_array_equality_with_error(&result, &[4.0; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float64_array::<8>();
                let arr2 = get_random_float64_array::<8>();
                let a = _mm512_loadu_pd(arr1.as_ptr());
                let b = _mm512_loadu_pd(arr2.as_ptr());
                let _ = _mm512_div_pd(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_max_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_max_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_min_ps() -> Result<(), String> {
    unsafe {
        let a = _mm512_set_ps(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
        let b = _mm512_set_ps(16.0, 15.0, 14.0, 13.0, 12.0, 11.0, 10.0, 9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0);
        let result = _mm512_min_ps(a, b);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<16>();
                let arr2 = get_random_float32_array::<16>();
                let a = _mm512_loadu_ps(arr1.as_ptr());
                let b = _mm512_loadu_ps(arr2.as_ptr());
                let _ = _mm512_min_ps(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm512_sqrt_ps() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0, 36.0, 49.0, 64.0, 81.0, 100.0, 121.0, 144.0, 169.0, 196.0, 225.0, 256.0, 289.0];
        let vec = _mm512_loadu_ps(data.as_ptr());
        let result = _mm512_sqrt_ps(vec);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<16>();
                let vec = _mm512_loadu_ps(arr.as_ptr());
                let _ = _mm512_sqrt_ps(vec);
            }
        }
    }

    Ok(())
}

fn test_mm512_set1_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_set1_ps(3.13);
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[3.13; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let _ = _mm512_set1_ps(value);
            }
        }
    }

    Ok(())
}

fn test_mm512_setzero_ps() -> Result<(), String> {
    unsafe {
        let result = _mm512_setzero_ps();
        let result = std::mem::transmute::<__m512, [f32; 16]>(result);
        check_float_array_equality_with_error(&result, &[0.0; 16])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm512_setzero_ps();
            }
        }
    }

    Ok(())
}

fn test_mm_cvtsd_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtss_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtss_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsd_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvti64_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvti64_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtu64_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtu64_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttsd_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttsd_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttss_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttss_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundi64_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsi64_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundi64_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundu64_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsi64_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundu64_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_si64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_si64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_si64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_i64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_si64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_u64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_abs_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_abs_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_abs_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_abs_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_abs_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mov_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mov_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mov_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mov_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mov_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mov_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mov_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mov_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mullo_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mullo_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_max_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_max_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_min_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_min_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_epu64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmaddsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmaddsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmaddsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmaddsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmaddsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmaddsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsubadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsubadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsubadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsubadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsubadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsubadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rcp14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rcp14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rcp14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rcp14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rcp14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rcp14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rsqrt14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rsqrt14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rsqrt14_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rsqrt14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rsqrt14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rsqrt14_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_ternarylogic_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_ternarylogic_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_ternarylogic_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_ternarylogic_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_ternarylogic_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_ternarylogic_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtps_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtps_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtpd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtpd_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtpd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtpd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi8_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi8_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi8_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi8_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu8_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu8_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu8_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu8_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi16_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi16_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi16_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi16_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu16_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu16_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu16_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu16_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi32_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu32_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu32_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi32_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi32_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepu32_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepu32_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtusepi32_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtusepi32_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtusepi64_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtusepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtusepi64_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtusepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtusepi64_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvt_roundps_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvt_roundps_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtps_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtps_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtph_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtph_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvttps_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvttps_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvttps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvttps_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvttpd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvttpd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i32scatter_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i32scatter_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i32scatter_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i32scatter_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i32scatter_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i32scatter_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i32scatter_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i32scatter_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i64scatter_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i64scatter_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i64scatter_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i64scatter_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i64scatter_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i64scatter_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_i64scatter_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_i64scatter_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i32gather_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i32gather_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i32gather_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i32gather_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i64gather_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i64gather_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i64gather_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mmask_i64gather_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compress_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_compress_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compress_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_compress_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compress_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_compress_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compress_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_compress_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compressstoreu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compressstoreu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compressstoreu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_compressstoreu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expand_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expand_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expand_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expand_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expand_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expand_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expand_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expand_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rol_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rol_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rol_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_ror_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_ror_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_ror_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rol_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rol_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rol_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_ror_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_ror_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_ror_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_slli_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_slli_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srli_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srli_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_slli_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_slli_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srli_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srli_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sll_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sll_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srl_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srl_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sll_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sll_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srl_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srl_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sra_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sra_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_sra_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sra_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sra_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srai_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srai_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_srai_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srai_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srai_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srav_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srav_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_srav_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srav_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srav_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rolv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rolv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rolv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rorv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rorv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rorv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rolv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rolv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rolv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rorv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rorv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rorv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sllv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sllv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srlv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srlv_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sllv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sllv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_srlv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_srlv_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permute_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permute_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permute_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permute_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutevar_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutevar_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutevar_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutevar_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_permutex2var_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutex2var_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutex2var_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask2_permutex2var_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_permutex2var_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutex2var_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutex2var_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask2_permutex2var_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_permutex2var_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutex2var_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutex2var_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask2_permutex2var_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_permutex2var_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_permutex2var_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_permutex2var_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask2_permutex2var_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_shuffle_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_shuffle_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_shuffle_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_shuffle_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_shuffle_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_shuffle_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_moveldup_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_moveldup_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_movehdup_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_movehdup_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_movedup_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_movedup_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpackhi_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpackhi_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpackhi_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpackhi_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpackhi_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpackhi_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpackhi_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpackhi_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpacklo_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpacklo_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpacklo_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpacklo_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpacklo_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpacklo_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_unpacklo_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_unpacklo_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_broadcastd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_broadcastd_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_broadcastq_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_broadcastq_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_broadcastss_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_broadcastss_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_blend_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_blend_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_blend_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_blend_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_alignr_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_alignr_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_alignr_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_alignr_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_alignr_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_alignr_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_and_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_and_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_and_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_and_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_or_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_or_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_or_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_or_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_or_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_or_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_xor_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_xor_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_xor_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_xor_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_xor_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_xor_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_andnot_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_andnot_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_andnot_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_andnot_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_test_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_test_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_test_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_test_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_testn_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_testn_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_testn_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_testn_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_set1_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_set1_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_set1_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_set1_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_ps_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_ps_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_pd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_pd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_ss_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_ss_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_round_ss_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_round_ss_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_sd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_sd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_round_sd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_round_sd_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmplt_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmplt_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpgt_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpgt_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmple_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmple_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpge_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpge_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpeq_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpeq_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpneq_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpneq_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_epu32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmplt_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmplt_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpgt_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpgt_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmple_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmple_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpge_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpge_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpeq_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpeq_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpneq_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpneq_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_epi32_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmplt_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmplt_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpgt_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpgt_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmple_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmple_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpge_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpge_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpeq_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpeq_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpneq_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpneq_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_epu64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmplt_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmplt_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpgt_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpgt_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmple_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmple_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpge_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpge_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpeq_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpeq_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmpneq_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmpneq_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cmp_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cmp_epi64_mask() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_loadu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtusepi64_storeu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_storeu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_loadu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_storeu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_load_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_store_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_load_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_store_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_loadu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_loadu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_loadu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_loadu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_loadu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_loadu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_loadu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_loadu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_load_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_load_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_storeu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_storeu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_storeu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_storeu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_store_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expandloadu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expandloadu_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expandloadu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expandloadu_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expandloadu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expandloadu_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_expandloadu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_expandloadu_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_move_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_move_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_move_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_move_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rsqrt14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rsqrt14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rsqrt14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rsqrt14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rsqrt14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rsqrt14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rcp14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rcp14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rcp14_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_rcp14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_rcp14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_rcp14_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_add_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_add_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_add_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_add_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_sub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_sub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mul_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mul_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_mul_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_mul_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_div_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_div_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_div_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_div_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_max_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_max_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_max_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_max_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_min_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_min_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_min_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_min_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_sqrt_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_sqrt_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_sqrt_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_sqrt_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getexp_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getexp_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getexp_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_getmant_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_getmant_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_getmant_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_roundscale_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_roundscale_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_roundscale_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_scalef_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_scalef_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_scalef_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fnmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fnmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmadd_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fnmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fnmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fnmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fnmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask3_fnmsub_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_fixupimm_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_fixupimm_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_fixupimm_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtss_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtss_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvtsd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvtsd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvt_roundss_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvt_roundss_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_mask_cvt_roundsd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_maskz_cvt_roundsd_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_si32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundss_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtss_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtss_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_si32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsd_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsd_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtsd_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundi32_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundsi32_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvt_roundu32_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvti32_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvti32_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_si32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundss_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttss_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttss_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_si32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtt_roundsd_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttsd_i32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvttsd_u32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtu32_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_cvtu32_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_comi_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

fn test_mm_comi_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}
