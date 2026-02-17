use std::arch::x86_64::{
    __m128, _mm_add_ss, _mm_cmpeq_ps, _mm_cmpge_ps, _mm_cmpgt_ps, _mm_cmple_ps, _mm_cmplt_ps, _mm_cvtsi32_ss, _mm_cvtss_f32, _mm_cvtss_si32, _mm_div_ss, _mm_loadu_ps, _mm_max_ss,
    _mm_min_ss, _mm_move_ss, _mm_movehl_ps, _mm_movelh_ps, _mm_mul_ss, _mm_rcp_ps, _mm_rcp_ss, _mm_rsqrt_ss, _mm_set_ps, _mm_set_ss, _mm_setzero_ps, _mm_shuffle_ps, _mm_sqrt_ss,
    _mm_sub_ss, _mm_unpackhi_ps, _mm_unpacklo_ps,
};

use log::info;

use crate::cpu::common::{check_float_array_equality, check_float_equality, check_int_equality, get_random_float, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cmpeq_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cmpeq_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = arr1;
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpeq_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpgt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmpgt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpgt_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmplt_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmplt_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[0.0, 0.0, f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmplt_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmpge_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmpge_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmpge_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cmple_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result = _mm_cmple_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[0.0, 0.0, f32::NAN, f32::NAN])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_cmple_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtss_f32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cvtss_f32(a);
        check_float_equality(result, 4.0)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = _mm_cvtss_f32(vec);
                check_float_equality(result, arr[0])?;
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi32_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_setzero_ps();
        let result = _mm_cvtsi32_ss(a, 42);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[42.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float() as i32;
                let vec = _mm_setzero_ps();
                let result = _mm_cvtsi32_ss(vec, value);
                let result = std::mem::transmute::<__m128, [f32; 4]>(result);
                check_float_array_equality(&result, &[value as f32, 0.0, 0.0, 0.0])?;
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_si32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let result = _mm_cvtss_si32(a);
        check_int_equality(result, 4)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let vec = _mm_set_ps(get_random_float(), get_random_float(), get_random_float(), value);
                let _ = _mm_cvtss_si32(vec);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_set_ss() -> Result<(), String> {
    unsafe {
        let result = _mm_set_ss(3.13);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[3.13, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let value = get_random_float();
                let result = _mm_set_ss(value);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_add_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[12.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_add_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 10.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 3.0);
        let result = _mm_sub_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[7.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_sub_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mul_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_mul_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[8.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_mul_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_div_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 8.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_div_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_div_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sqrt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 16.0);
        let result = _mm_sqrt_ss(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = _mm_sqrt_ss(vec);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp_ss() -> Result<(), String> {
    unsafe {
        let data = [4.0, 9.0, 16.0, 25.0];
        let data_128 = _mm_loadu_ps(data.as_ptr());
        let result = _mm_rcp_ss(data_128);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[0.25, 9.0, 16.0, 25.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let data_128 = _mm_loadu_ps(arr.as_ptr());
                let result = _mm_rcp_ss(data_128);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rcp_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 4.0, 8.0);
        let result = _mm_rcp_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[0.125, 0.25, 0.5, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = _mm_rcp_ps(vec);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rsqrt_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 16.0);
        let result = _mm_rsqrt_ss(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[0.25, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let vec = _mm_set_ps(arr[3], arr[2], arr[1], arr[0]);
                let result = _mm_rsqrt_ss(vec);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_min_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[2.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_min_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 2.0);
        let result = _mm_max_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_max_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_shuffle_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);

        let result = _mm_shuffle_ps::<0x1B>(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[1.0, 2.0, 7.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_shuffle_ps::<0x1B>(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_unpackhi_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[2.0, 6.0, 1.0, 5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_unpackhi_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_unpacklo_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[4.0, 8.0, 3.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_unpacklo_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_movehl_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_movehl_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[6.0, 5.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_movehl_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_movelh_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_movelh_ps(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[4.0, 3.0, 8.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_movelh_ps(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_move_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let result = _mm_move_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_float_array_equality(&result, &[8.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = get_random_float32_array::<4>();
                let arr2 = get_random_float32_array::<4>();
                let vec1 = _mm_set_ps(arr1[3], arr1[2], arr1[1], arr1[0]);
                let vec2 = _mm_set_ps(arr2[3], arr2[2], arr2[1], arr2[0]);
                let result = _mm_move_ss(vec1, vec2);
                let _result = std::mem::transmute::<__m128, [f32; 4]>(result);
            }
        }
    }

    Ok(())
}
